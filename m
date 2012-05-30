From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Wed, 30 May 2012 14:31:57 -0500
Subject: [PATCH 0/2] OMAP: mailbox initial device tree support
In-Reply-To: <4FBE574F.6070408@ti.com>
References: <1335894460-19941-1-git-send-email-omar.luna@linaro.org>
 <B5906170F1614E41A8A28DE3B8D121433EA68F6D@DBDE01.ent.ti.com>
 <4FBE574F.6070408@ti.com>
Message-ID: <CALLhW=7hdmTZsipbVvGXNNCwE=NsvYJc9mUWRff3V7CA=_vskQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24 May 2012 10:44, Cousson, Benoit <b-cousson@ti.com> wrote:
> On 5/2/2012 7:42 AM, Bedia, Vaibhav wrote:
>>
>> Hi Omar,
>>
>> On Tue, May 01, 2012 at 23:17:38, Omar Ramirez Luna wrote:
>>>
>>> To allow mailbox driver to function with device tree.
>>>
>>> Tested in OMAP4 and OMAP3. OMAP2 untested.
>>
>>
>> I think the mailbox code needs a cleanup similar to what you
>> had proposed earlier [1] before the device tree support is added.
>>
>> We probably need to decide whether the number of mailbox sub-modules
>> should be part of hwmod attribute or come from device tree. IMO the
>> static allocation of the mailboxes is better suited in the device-tree
>> data.
>
>
> Ideally yes, but that assumes we are supporting only DT boot method, which
> is still not the case today.
>
> That being said, the driver might still be able to leverage DT if available
> already.
>
>
> This can be done later as well.
>
> Omar,
> That's up to you.

Thanks for the ack on the 2nd patch.

Yes, I think these changes doesn't depend on the cleanup of the
driver, they could be included prior to them.

Regards,

Omar
