From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Dec 2012 16:01:27 +0100
Subject: [GIT PULL] ARM: arm-soc fixes for 3.8
In-Reply-To: <20121218065502.GA12865@quad.lixom.net>
References: <20121218065502.GA12865@quad.lixom.net>
Message-ID: <50D08547.8040405@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Le 18/12/2012 07:55, Olof Johansson a ?crit :
> Maxime Ripard (1):
>       ARM: sunxi: Change device tree naming scheme for sunxi

There's something odd about this one (commit 68136b10). The patch that
you seem to have applied differs from the one I sent. The DTs files
appears to have not been renamed, while in the patch I sent
(http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137105.html),
it's the case.

Do you know what happened here? What can we do to fix that?

Maxime
-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
