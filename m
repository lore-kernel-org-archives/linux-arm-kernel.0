From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Apr 2012 10:26:30 +0200
Subject: [PATCH] pinctrl: fix build failure on PPC
In-Reply-To: <4F844E52.3080902@wwwdotorg.org>
References: <1334044357-14486-1-git-send-email-linus.walleij@stericsson.com>
 <4F844E52.3080902@wwwdotorg.org>
Message-ID: <CACRpkdYPD4iA2vdy-VOP2E+FfESJmbuMtLDVi0rGBn6FCCzuyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 10, 2012 at 5:14 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/10/2012 01:52 AM, Linus Walleij wrote:

>> So let's use some local Kconfig option that depends on both OF
>> and PINCTRL so that this file is only compiled if you have
>> both enabled.
>
> It seems simpler to just fix the Makefile to only compile the file when
> its needed directly, without introducing a new Kconfig option. See
> https://lkml.org/lkml/2012/4/3/445.

But I think it is basically a config problem, not a compilation problem,
that is why I did it this way.

But I won't be stubborn about it ... I'll see if I can just switch that one
patch out then.

Yours,
Linus Walleij
