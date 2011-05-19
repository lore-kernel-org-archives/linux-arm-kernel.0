From: vitalywool@gmail.com (Vitaly Wool)
Date: Thu, 19 May 2011 19:40:30 +0200
Subject: [PATCH 1/2] spi/pl022: timeout on polled transfer v2
In-Reply-To: <BANLkTi=mQbPt9rcqEVyMLy3rkF2D7FMh=g@mail.gmail.com>
References: <1305821134-26147-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTi=s4nzi=5f+Vvh3ABuspnKXQVUfLw@mail.gmail.com>
	<BANLkTi=mQbPt9rcqEVyMLy3rkF2D7FMh=g@mail.gmail.com>
Message-ID: <BANLkTi=COt5Te4bF1M30A+R4Vqnz=kWiJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2011 at 7:36 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> just out of curiosity: is it a busy wait? Looks like it is...
>
> Yep that's the polling mode part. IRQ and DMA mode should
> be the norm I guess.
>
> Magnus: do you have a specific use case for this thing?

Well, adding cpu_relax() somewhere in the loop might be not a bad idea...

Thanks,
   Vitaly
