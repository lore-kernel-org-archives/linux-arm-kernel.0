From: jassisinghbrar@gmail.com (jassi brar)
Date: Tue, 15 Sep 2009 21:05:39 +0900
Subject: [PATCH 4/7] S3C64XX DMA: S3C2410_DMAF_CIRCULAR disable
In-Reply-To: <20090915115205.GM22878@rakim.wolfsonmicro.main>
References: <1253008882-7587-1-git-send-email-jassi.brar@samsung.com>
	<20090915100751.GC22878@rakim.wolfsonmicro.main>
	<1b68c6790909150401k4bc958edl7eea0062a4d4fd38@mail.gmail.com>
	<20090915115205.GM22878@rakim.wolfsonmicro.main>
Message-ID: <1b68c6790909150505v449d2dbci18a12f634f28232f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 8:52 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Sep 15, 2009 at 08:01:39PM +0900, jassi brar wrote:
>> On Tue, Sep 15, 2009 at 7:07 PM, Mark Brown
>
>> > ?Though I'm a bit concerned that if something has
>> > actually tried to set up circular DMA it might get upset if that's
>> > ignored (not that I've looked in detail).
>
>> That shudn't be an issue.
>> S3C64xx dma isn't used by any code other than I2S which doesn't
>> have any machine driver.
>
> I'd expect that to change very soon, though?
Yes, tomorrow i plan to submit a basic SMDK6410-WM8580 I2S-v4
*2channels* driver.
Later my spi driver too, that makes use of DMA.
