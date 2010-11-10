From: hari.kanigeri@gmail.com (Hari Kanigeri)
Date: Wed, 10 Nov 2010 10:56:23 -0600
Subject: [PATCH 0/6] [v2] omap:mailbox-enhancements and fixes
In-Reply-To: <4CDACB0E.3050403@ti.com>
References: <1289393121-7911-1-git-send-email-h-kanigeri2@ti.com>
	<4CDACB0E.3050403@ti.com>
Message-ID: <AANLkTi=jL-aV0Xn3rcnZwaYLz9nY5QwXbGPHsdq1R2Gz@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

Thanks for your comments.

On Wed, Nov 10, 2010 at 10:40 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Hari,
>
> On 11/10/2010 1:45 PM, Hari Kanigeri wrote:
>>
>> Thanks to Rene Sapiens and Omar Ramirez for their inputs on initial patch
>> set.
>> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg37278.html
>>
>> The patch set addresses the following review comments from Rene and Omar.
>> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg37626.html
>> https://patchwork.kernel.org/patch/255091/
>> https://patchwork.kernel.org/patch/255081/
>>
>> Following patches are changed because of above review comments:
>> omap:mailbox-send message in process context
>> omap:mailbox-add notification support for multiple readers
>>
>> Following patch is dropped from initial patch set
>> omap:mailbox-resolve multiple receiver problem
>>
>> The patch set is tested on omap4 SDP board.
>>
>> Fernando Guzman Lugo (1):
>> ? mailbox: change full flag per mailbox queue instead of global
>>
>> Hari Kanigeri (5):
>> ? omap:mailbox: fix rx interrupt disable in omap4
>> ? omap:mailbox-fix checkpatch warnings
>
> That one is weird? How can you submit a patch that fix checkpatch?

Why weird if the patch is fixing the checkpatch warnings that were
already present in the code ?
The other option is to leave the checkpatch warnings in the code :)

> In theory you should not send any patch that generate checkpatch error or
> warning.
>
>> ? omap:mailbox-send message in process context
>> ? omap:mailbox-add notification support for multiple readers
>> ? omap:clocks44x-add dummy clock for mailbox
>
> We are trying to enforce some consistency in the subjects name so you should
> name your patches like that:

Good point, thanks for pointing about consistency. I wasn't aware
about the rule to use OMAP in caps.
I will fix it.

Thank you,
Best regards,
Hari
