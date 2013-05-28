From: olof@lixom.net (Olof Johansson)
Date: Mon, 27 May 2013 19:31:58 -0700
Subject: [GIT PULL] ARM: mvebu: fixes for v3.10 (round 3)
In-Reply-To: <20130527185436.GN31290@titan.lakedaemon.net>
References: <20130527185436.GN31290@titan.lakedaemon.net>
Message-ID: <20130528023158.GB13532@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 27, 2013 at 02:54:36PM -0400, Jason Cooper wrote:

> Thomas Petazzoni (2):
>       arm: mvebu: fix length of SATA registers area in .dtsi
>       arm: mvebu: fix length of Ethernet registers area in .dtsi

Is this an actual regression in 3.10?

I can understand having to fix this before the static mapping is removed,
but if it's still there for 3.10, then it makes more sense to queue these
fixes for 3.11 (we tend to collect a "fixes-non-critical" that is merged
before any other branches in the next merge window).


-Olof
