From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Mar 2013 22:28:54 -0600
Subject: [RFC PATCH] ARM: bcm2835: convert to multi-platform
In-Reply-To: <20130313020732.GA27654@S2101-09.ap.freescale.net>
References: <1363064399-19559-1-git-send-email-swarren@wwwdotorg.org>
 <20130312080206.GI18574@S2101-09.ap.freescale.net>
 <513F7254.1060301@wwwdotorg.org>
 <20130313020732.GA27654@S2101-09.ap.freescale.net>
Message-ID: <51400086.5090300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2013 08:07 PM, Shawn Guo wrote:
> On Tue, Mar 12, 2013 at 12:22:12PM -0600, Stephen Warren wrote:
>>>> TO DO:
>>>> * It'd be nice to restore uncompress.h. I need to take a look at Shawn
>>>>   Guo's patches related to this, and presumably rebase this on top of
>>>>   them.
>>>
>>> You do not need to restore uncompress.h, and from what I've seen,
>>> with my patches in place, uncompress debug will probably just work
>>> on BCM2835 out of box (you need to have DEBUG_LL selected for BCM2835).
>>
>> Should the usual "Uncompressing kernel" message show up automatically
>> then? I don't think it did, which is why I mentioned that "TO DO". I
>> almost always run with DEBUG_LL enabled and earlyprintk in the kernel
>> command-line, but I should double-check I didn't accidentally drop it
>> when testing this patch.
> 
> Yes, if you have both DEBUG_LL and DEBUG_BCM2835 set, I would expect
> you can see "Uncompressing kernel" message.

Ah yes. I just tried it again, and it does work perfectly. Thanks.
