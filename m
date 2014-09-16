From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 16 Sep 2014 14:57:36 +0200
Subject: [PATCH 00/16 v9] omap 8250 based uart + DMA
In-Reply-To: <5416D2A0.5020407@linutronix.de>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <20140912224324.GK18849@atomide.com> <5416D2A0.5020407@linutronix.de>
Message-ID: <541833C0.5020106@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2014 01:50 PM, Sebastian Andrzej Siewior wrote:
> I changed the restore function the fix the am335x-evm + less "freeze".
> And now we have this. So let me search?

IER was 0 by accident. It fixed in TX path.
I pushed uart_v10_pre1 which should have it fixed aport from other
things?
I am going to address the review comments, to split the DMA callbacks
as requested and if nobody comes up with something fancy we will have a
v10 :)

>> Regards,
>>
>> Tony

Sebastian
