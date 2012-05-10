From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 10 May 2012 13:28:36 +0000
Subject: [PATCHv3] Add ADC driver for Atmel G20, G45 and X5 boards
In-Reply-To: <4FAB815A.8040109@atmel.com>
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
 <4FAB7D29.9000107@free-electrons.com> <4FAB815A.8040109@atmel.com>
Message-ID: <201205101328.36524.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 May 2012, Nicolas Ferre wrote:
> So I would really like to keep the non-DT probing. This will give the
> ability for users to experiment IIO/ADC with whichever kernel revision,
> whichever AT91 SoC they like.
> 
> Arnd, we will have to agree on a way to push this work into mainline,
> but please consider keeping the non-DT part for this driver.

Ok. If the non-DT part is important to you, I suggest you merge it
all through the IIO tree, to avoid dependency problems with the
platform data header file.

Please add my Acked-by for the arch/arm patches.

	Arnd
