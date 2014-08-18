From: m-karicheri2@ti.com (Murali Karicheri)
Date: Mon, 18 Aug 2014 10:58:13 -0400
Subject: [PATCH v7 0/5] Add Keystone PCIe controller driver
In-Reply-To: <CAErSpo6gEVP7XbiPZ90MP4zn5mrjaJLZTW0_sdjg9Q6HjnnkFg@mail.gmail.com>
References: <1405961925-27248-1-git-send-email-m-karicheri2@ti.com>
 <20140722225708.GB27965@google.com> <53CFD444.4010700@ti.com>
 <CAErSpo6gEVP7XbiPZ90MP4zn5mrjaJLZTW0_sdjg9Q6HjnnkFg@mail.gmail.com>
Message-ID: <53F21485.9000700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn,

On 07/23/2014 12:43 PM, Bjorn Helgaas wrote:
> On Wed, Jul 23, 2014 at 9:27 AM, Murali Karicheri<m-karicheri2@ti.com>  wrote:
>>
>> Bjorn,
>>
>>
>> On 07/22/2014 06:57 PM, Bjorn Helgaas wrote:
>>>
>>> On Mon, Jul 21, 2014 at 12:58:40PM -0400, Murali Karicheri wrote:
>>
>>
>>>> Murali Karicheri (5):
>>>>     PCI: designware: add rd[wr]_other_conf API
>>>>     PCI: designware: refactor MSI code to work with v3.65 dw hardware
>>>
>>>
>>> I applied the above two to my pci/host-designware branch.  The rest didn't
>>> apply cleanly because I applied Kishon's DRA7xx changes first, and there
>>> are several conflicts.  Can you rebase the rest of them on top of
>>> pci/host-designware?
>>
>>
>> Thanks for applying 1 and 2.
>>
>> I will fix up 3 based on your branch and send you updated patch 3 and 4
>> today.  Hope you can apply this updated patch so that I don't have to
>> address any rebase issues. Regarding the MRSS comment, I will discuss it on
>> that thread and send you a fix for removing the bootargs depedency based on
>> what comes out of that discussion. Is that fine?
>
> Yep, sounds reasonable.  I'm about to leave for vacation, so I won't
> be able to apply these until mid-August, but I think we can still get
> them into v3.17 since it's new hardware that shouldn't affect anything
> else.
Could you please apply my re-send patches [1] on top of patch 1 and 2? I 
have reposted it addressing some of the comments and replied to others 
as there are no action.

[1] http://www.spinics.net/lists/linux-pci/msg33178.html

>
> For MRSS, I'll probably open a bugzilla and reference it in the
> changelog just so we don't forget about it.

I have posted another pactch to remove the bootarg depedency and already 
incorporated comments from Jason Gunthorpe who has discussed this on the 
list. Please review and apply it if it looks good or comment.

https://lkml.org/lkml/2014/8/8/486

Thanks and regards,

Murali
