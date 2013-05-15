From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 May 2013 14:55:12 +0200
Subject: [PATCHv2 00/20] Cleanup irqchip_init calls
In-Reply-To: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1368545933-7430-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201305151455.12603.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 May 2013, Maxime Ripard wrote:
> This is a splitted up version of the patch I previously sent to
> remove the explicit declaration of irqchip_init as the init_irq callback in
> the machine descriptions.
> 
> Since it was a pretty tricky patch to merge, since it was touching a lot of
> different platforms, I splitted it for each platforms, and rebased it on top
> of 3.10-rc1.
> 
> The best way to merge it is probably that each one of us take into their tree
> the patches that are relevant for our architecture and send them to arm-soc
> later on.

Sounds good to me. I'm sure that some platform maintainers will fail to
apply this though. Could you send whatever remains as a separate branch
in a couple of weeks so we can directly apply it to next/cleanup?

	Arnd
