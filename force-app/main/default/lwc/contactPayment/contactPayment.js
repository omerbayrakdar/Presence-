import { LightningElement, wire,track,api } from 'lwc';
import getContactList from  '@salesforce/apex/GetContactData.getContactList';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
export default class ContactPayment extends LightningElement {

    handleToggleSection(event) {
        this.activeSectionMessage =
            'Open section name:  ' + event.detail.openSections;
    }

    handleSetActiveSectionC() {
        const accordion = this.template.querySelector('.example-accordion');

        accordion.activeSectionName = 'C';
    }


    @track contacts;
    @track error;
    allContactList;
    @wire(getContactList)
    wiredContacts(result) {
        this.allContactList = result;
        if (result.data) {
            console.log('contact data', result.data);
            var data = JSON.parse(JSON.stringify(result.data));
            for(var i = 0; i < data.length; i++ ){
                data[i]['showCreatePayment'] = false;
            }
            this.contacts = data;
        } else if (result.error) {
            console.log(result.error);
            this.error = result.error;
        }
    }


    handleDelete(event) {
        const recordId = event.target.dataset.id;
        deleteRecord(recordId)
        .then(() => {
            refreshApex(this.allContactList);
            this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Record deleted',
                variant: 'success'
            })
            );
        })
        .catch(error => {
            this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error deleting record',
                message: error.body.message,
                variant: 'error'
                })
            );
        });
    }
     handleSuccess(event) {
      refreshApex(this.allContactList);
            this.showCreatePayment = false;
            this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Record Created',
                variant: 'success'
            })
            );
    }
    handleCreatePayment(event){
        var tempcontacts = this.contacts;
        for(var i = 0; i < tempcontacts.length; i++ ){
            if(tempcontacts[i].Id == event.target.dataset.id){
                tempcontacts[i].showCreatePayment = true;
            }else{
                tempcontacts[i].showCreatePayment = false;
            }
        }
    }
}