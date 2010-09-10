From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 10 Sep 2010 20:45:09 +0200
Subject: [PATCH] ARM: make TCM allocation static and common for all archs
In-Reply-To: <20100910161621.GF21361@game.jcrosoft.org>
References: <1278717389-8964-1-git-send-email-linus.walleij@stericsson.com>
	<20100910161621.GF21361@game.jcrosoft.org>
Message-ID: <AANLkTimn4mm+qJ8003v=no5uZj-_exiD3x9FK4c2fVt+@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/10 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:

> Any feed back about the tcm?

None other than it works for me on U300 and RealView PB1176.

Some two people have mailed me in private and told me they're using
it for out-of-tree stuff (ARM 926 based I think.)

Alessandro Rubin tried to use it on the Nomadik NHK8815 but it
turns out that the "TCM" in that machine is actually a ROM and
a locked-down RAM that is used for some security stuff (not
TrustZone!).

Yours,
Linus Walleij
