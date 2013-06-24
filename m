From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Mon, 24 Jun 2013 14:39:05 +0200
Subject: [PATCH] pinctrl: establish pull-up/pull-down terminology
In-Reply-To: <CACRpkdYMe+q2GUXooSeVVua3-AHDJFfWQu21bn45b_omsA7FAQ@mail.gmail.com>
References: <1371379548-6482-1-git-send-email-linus.walleij@stericsson.com>
 <201306220139.28794.heiko@sntech.de>
 <CACRpkdYMe+q2GUXooSeVVua3-AHDJFfWQu21bn45b_omsA7FAQ@mail.gmail.com>
Message-ID: <201306241439.05875.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 24. Juni 2013, 14:24:12 schrieb Linus Walleij:
> On Sat, Jun 22, 2013 at 1:39 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > Am Samstag, 22. Juni 2013, 01:30:18 schrieb Laurent Pinchart:
> >> [Stephen]
> >> 
> >> > IIRC the idea of the PULL_PIN_DEFAULT was to avoid having to specify
> >> > UP/DOWN for each pin/group, but could just say "default", which would
> >> > then reduce the number of pinctrl mapping table entries or pinctrl DT
> >> > property entries.
> >> 
> >> I may be mistaken, but I've understood the PULL_PIN_DEFAULT option as a
> >> way to select the default bias configuration when the default value is
> >> hardware- controlled, not as a pure software option.
> > 
> > Yep that was the original intent ... to handle hardware that hides the
> > complete logic from the software and you only get to turn it on or off,
> > while the direction and other params are determined internally for
> > example by the pin function.
> 
> Heiko, can you send a documentation patch to clarify this so we
> don't get any misunderstandings?
> 
> Maybe it'd be useful for software purposes as well, but let's save
> that for when it gets used like that.

will try to get this (and the changes from the other mail) done today

Heiko
