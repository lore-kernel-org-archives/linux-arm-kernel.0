From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 06 Jun 2013 15:27:21 -0700
Subject: [PATCH 13/14] ARM: AM33XX: hwmod data: irq,
 dma and addr info clean up
In-Reply-To: <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com> (Paul
 Walmsley's message of "Thu, 6 Jun 2013 04:00:39 +0000 (UTC)")
References: <1369845494-30231-1-git-send-email-santosh.shilimkar@ti.com>
 <1369845494-30231-14-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.02.1306060355320.15042@utopia.booyaka.com>
Message-ID: <87zjv2ooxi.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> On Wed, 29 May 2013, Santosh Shilimkar wrote:
>
>> From: Vaibhav Hiremath <hvaibhav@ti.com>
>> 
>> AM33XX only supports DT boot mode and with addition of
>> extracting module resources like, irq, dma and address space
>> from DT block, so now we can remove duplicate information from
>> hwmod data file.
>
> OK, guess I'll take your word for it that it all works.  The
> BeagleBone-white with appended DTB hasn't booted here since v3.7.
> And the BeagleBone-black with discrete DTB doesn't boot at all with
> current mainline, only with the TI vendor kernel & DTB...

Anyone care to shed light on what's missing for BeagleBone boot with
mainline currently?  

I've also not been able to boot a mainline kernel on the BeagleBone for
some time.

Kevin
