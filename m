From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 15 Feb 2010 14:07:13 +0100
Subject: [PATCH 3/3] [U300] Set f_max to 24 MHz for MMC
In-Reply-To: <4B7936CE.9020402@csr.com>
References: <1266233040-17124-1-git-send-email-linus.walleij@stericsson.com>
	<4B7936CE.9020402@csr.com>
Message-ID: <A6D19A13FE030A409EC4362C172E091F0E84AFBD@eseldmw101.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[David Vrabel]

> Linus Walleij wrote:
> > 
> > +	mmci_card->mmc0_plat_data.f_max = 24*1024*1024;
> 
> Is the frequency really 25165824 Hz and not 24000000 Hz?

Or, yes it is 24000000, as was your question, hm,
the 1024 was probably out of habit, I'll change to
24*1000*1000.

Sorry for getting it all backwards, I need vacation.

Linus Walleij
