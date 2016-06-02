From: bernhard.nortmann@web.de (Bernhard Nortmann)
Date: Thu, 2 Jun 2016 11:15:55 +0200
Subject: [linux-sunxi] [PATCH] [V2] ARM: dts: sun7i: Add dts file for
 Bananapi M1 Plus board
In-Reply-To: <20160602081638.GG4908@lukather>
References: <20160602023623.5761-1-luoyi.ly@gmail.com>
 <CAGRGNgUiGaxoVxtq=k8NG5mCqEXS9fd-ry1vvVJfzb+R2ATMTA@mail.gmail.com>
 <20160602081638.GG4908@lukather>
Message-ID: <574FF94B.3020309@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.06.2016 um 10:16 schrieb Maxime Ripard:
> [...]
> Yes, everything that is shared with the banana-pro (which, judging
> from Bernhard, is pretty much everything but a GPIO) should be merged
> in the banapro DT.
>
> Maxime
>

Don't take my word for granted, as I do not own this hardware or know it
particularly well. There is no doubt that "BPi-M1+" and "Banana Pro" are
very similar, but if in doubt the information form the wiki should be 
verified.

@luoyi:

You seem to be using an editor that uses 4 spaces for displaying a <TAB>.
It looks like that makes you prone to whitespace formatting issues, which
have shown up in both versions of the .dts you submitted so far.

Please double-check that you're using TABs for indentation and they weren't
mixed up with SPACEs accidentally. (Most editors will also offer a setting
that allows you to display "non-printable" chars, where you might be able to
distinguish whitespace better.)

Regards, B. Nortmann
