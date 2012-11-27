From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Nov 2012 08:44:29 +0000
Subject: [Patch v6 4/4] ASoC: at91sam9g20ek-wm8731: convert to dt support
In-Reply-To: <50B42B4B.90407@atmel.com>
References: <1352887751-21848-1-git-send-email-voice.shen@atmel.com>
 <201211262123.42812.arnd@arndb.de> <50B42B4B.90407@atmel.com>
Message-ID: <201211270844.29311.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 November 2012, Bo Shen wrote:
> >
> > ERROR (phandle_references): Reference to non-existent node or label "pinctrl_ssc0_tx"
> 
> Yes, this is because there is a cross merge patch at: 
> https://patchwork.kernel.org/patch/1776941/ acked by Mark Brown, however 
> it does not merged.

I think I'm missing context here. What's holding this up? It looks like it should
have been merged before 531f67e41d, possibly into both arm-soc and asoc.

	Arnd
