From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 26 May 2011 05:05:20 +0200
Subject: [PATCH] arm: vexpress: move v2m clock init to init_early
In-Reply-To: <1306362653-25668-1-git-send-email-robherring2@gmail.com>
References: <1306362653-25668-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110526030520.GB19723@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:30 Wed 25 May     , Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Commit 7ff550de99141cbd3be0129d563cc4554fdde9f6 breaks vexpress booting. The
> v2m clock table needs to be setup in init_early before the timer
> initialization occurs.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  arch/arm/mach-vexpress/v2m.c |   15 +++++++--------
>  include/linux/libata.h       |    4 ++--
why do you touch the libata?

Best Regads,
J.
