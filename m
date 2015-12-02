From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Wed, 2 Dec 2015 01:25:39 +0100
Subject: [PATCH 10/10] ARM: dts: Fix dm814x pinctrl address and mask
In-Reply-To: <1449013103-23238-11-git-send-email-tony@atomide.com>
References: <1449013103-23238-1-git-send-email-tony@atomide.com>
 <1449013103-23238-11-git-send-email-tony@atomide.com>
Message-ID: <CAALWOA9LtWxFmKB_My7cv4KODBEmyPm=dUb=tPuap79fm7FkxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 December 2015 at 00:38, Tony Lindgren <tony@atomide.com> wrote:
> -                                       pinctrl-single,function-mask = <0x300ff>;
> +                                       pinctrl-single,function-mask = <0x707ff>;

Reminder that silicon revision 2.1 and older require input enabled
(bit 18 set) for all 3.3V I/Os to avoid cumulative hardware damage.
(Errata advisory 2.1.87)
