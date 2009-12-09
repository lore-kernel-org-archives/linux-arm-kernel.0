From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 8 Dec 2009 17:25:59 -0700
Subject: [PATCH 0/5] spi-imx: some updates
In-Reply-To: <20091208153239.af0b5bb8.akpm@linux-foundation.org>
References: <20091208211258.GA13706@pengutronix.de>
	<20091208153239.af0b5bb8.akpm@linux-foundation.org>
Message-ID: <fa686aa40912081625y3750a7fegbac38926182e38c6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/12/8 Andrew Morton <akpm@linux-foundation.org>:
> On Tue, 8 Dec 2009 22:12:58 +0100
> Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:
>
>> this series depends on "spi: drain MXC SPI transfer buffer when probing
>> device" which is currently in -mm and also included in my spi-imx branch
>> (see below). ?IMHO at least my first patch should go into .33 as it
>> fixes an oops.
>
> I queued all five for 2.6.33.

I had also picked up "drain MXC SPI transfer..." into my next-spi tree
earlier today.  After a few days I'll send Linus a pull request.  I
just need to make sure that Ben's tree gets pulled first because I've
got other stuff in there depending on it.

> Once I've merged up the current -mm patch queue:
[... list of patches snipped ...]
> I shall stop sending SPI patches to Linus. ?I'll send any which I
> accumulate to Grant instead.

I'm new to the job, so I'm being cautions about which things I'm pick
up.  However, I'll happily merge anything that Andrew says is okay.
Andrew, when in the merge window do you typically send out patch
queues?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
