From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Jul 2014 04:35:16 -0700
Subject: [PATCH 2/2] ARM: DTS: am335x-evmsk: Enable the McASP FIFO for
 audio
In-Reply-To: <1404381083-27029-2-git-send-email-peter.ujfalusi@ti.com>
References: <1404381083-27029-1-git-send-email-peter.ujfalusi@ti.com>
 <1404381083-27029-2-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20140707113516.GR28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140703 02:53]:
> The use of FIFO in McASP can reduce the risk of audio under/overrun and
> lowers the load on the memories since the DMA will operate in bursts.

Applying both into omap-for-v3.16/fixes thanks.

Tony
