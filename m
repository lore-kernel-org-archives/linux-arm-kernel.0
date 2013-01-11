From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 11 Jan 2013 14:33:34 -0500
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <20130111191808.GA18512@amt.cnet>
References: <1357866627.27576.21@snotra>
 <709FA96C-A3EF-489C-B0E9-59EEA7F8E62F@virtualopensystems.com>
 <20130111183907.GA15113@amt.cnet>
 <B5FF73B8-DAB5-4B6D-977C-7908483F660B@suse.de>
 <20130111191808.GA18512@amt.cnet>
Message-ID: <CANM98q+ud7EetQ3K-T4CftJUyV5xhUXNVPQ7NP7yBvLz4YjFgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 2:18 PM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
>> > Can you make KVM_SET_ARM_DEVICE address extensible?
>> > Add some reserved space and a flags field.
>>
>> Can't we do this for the new ioctl that we all would agree on rather than the interim one that's only a short term solution for a greater problem?
>>
>>
>> Alex
>
> OK.
>

Good. It's decided - the KVM/ARM patches remain in their current state
with an ARM specific ioctl, and will transition to something generic
post merge.

-Christoffer
