From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Apr 2014 15:57:31 +0200
Subject: [PATCH 11/11] pinctrl: single: Clear pin interrupts enabled by
 bootloader
In-Reply-To: <20140422161033.GC19317@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-12-git-send-email-tony@atomide.com>
 <CACRpkdYu2Obo8kuA2D9a33K_KCF-LPza=+reEpFnq8JFK6jOCg@mail.gmail.com>
 <20140422161033.GC19317@atomide.com>
Message-ID: <CACRpkdZeUTugwxaxCUBDVE3b+ak21m8C2Ff4N5rZ3+i5OdQXyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 6:10 PM, Tony Lindgren <tony@atomide.com> wrote:

>> Shall I apply this patch or will you funnel it through ARM SoC
>> due to deps?
>
> No deps except boards hanging without it.. Please feel free to
> take this one, prererrably as a fix for the -rc series if no
> objections.

Yes this is -rc material. Queued for fixes. Thanks!

Yours,
Linus Walleij
