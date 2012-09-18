From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2012 14:22:59 +0200
Subject: [PATCH v2 04/15] dmaengine: Pass no_wakeup parameter via
 device_prep_dma_cyclic() callback
In-Reply-To: <1347958810.1943.176.camel@vkoul-udesk3>
References: <1347543485-339-1-git-send-email-peter.ujfalusi@ti.com>
 <1347543485-339-5-git-send-email-peter.ujfalusi@ti.com>
 <CACRpkdYAxFzPAZgMsdj9C3YVLzMc_w41Xs0SiqX-1DWaZqxAdw@mail.gmail.com>
 <20120918083146.GE12445@n2100.arm.linux.org.uk>
 <1347958810.1943.176.camel@vkoul-udesk3>
Message-ID: <CACRpkdbphfZ+Q9L1H3x_cs_nxjYYg4xuerOHJzzdkogsKu948Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 11:00 AM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Tue, 2012-09-18 at 09:31 +0100, Russell King - ARM Linux wrote:
>> On Mon, Sep 17, 2012 at 11:01:23AM +0200, Linus Walleij wrote:
>> > On Thu, Sep 13, 2012 at 3:37 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> >
>> > After some discussion with clever people I know I have come to the conclusion
>> > that this is a good idea, so:
>> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> NAKed-by: me
>>
>> If you look at the other sub-threads of the patch you're acking, you'll
>> notice that there's a v3 of this patch set which changes the way this is
>> done.
>
> Was it a genuine mistake, think v3 reply v2? Or less caffeine..... :)

I think both, stupid me.
Ack on v3 indeed, I was probably fooled by some gmail autothreading, grrr.

Yours,
Linus Walleij
