From: jassisinghbrar@gmail.com (jassi brar)
Date: Wed, 9 Dec 2009 09:47:17 +0900
Subject: [spi-devel-general] [PATCH 0/5] spi-imx: some updates
In-Reply-To: <fa686aa40912081625y3750a7fegbac38926182e38c6@mail.gmail.com>
References: <20091208211258.GA13706@pengutronix.de>
	<20091208153239.af0b5bb8.akpm@linux-foundation.org>
	<fa686aa40912081625y3750a7fegbac38926182e38c6@mail.gmail.com>
Message-ID: <1b68c6790912081647p39f0b285q2c164ab41c673aeb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 9, 2009 at 9:25 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> 2009/12/8 Andrew Morton <akpm@linux-foundation.org>:
>> On Tue, 8 Dec 2009 22:12:58 +0100
>> Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de> wrote:
>>
>>> this series depends on "spi: drain MXC SPI transfer buffer when probing
>>> device" which is currently in -mm and also included in my spi-imx branch
>>> (see below). ?IMHO at least my first patch should go into .33 as it
>>> fixes an oops.
>>
>> I queued all five for 2.6.33.
>
> I had also picked up "drain MXC SPI transfer..." into my next-spi tree
> earlier today. ?After a few days I'll send Linus a pull request. ?I
> just need to make sure that Ben's tree gets pulled first because I've
> got other stuff in there depending on it.
>
>> Once I've merged up the current -mm patch queue:
> [... list of patches snipped ...]
>> I shall stop sending SPI patches to Linus. ?I'll send any which I
>> accumulate to Grant instead.
>
> I'm new to the job, so I'm being cautions about which things I'm pick
> up. ?However, I'll happily merge anything that Andrew says is okay.
> Andrew, when in the merge window do you typically send out patch
> queues?
>

Grant, may I know of your tree, if it's public?
thanks
