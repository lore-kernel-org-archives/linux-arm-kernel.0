From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Dec 2013 10:54:36 +0800
Subject: [PATCH v7 10/14] usb: phy-mxs: add controller id
In-Reply-To: <20131224020916.GC13518@shlinux1.ap.freescale.net>
References: <1387525930-27313-1-git-send-email-peter.chen@freescale.com>
 <1387525930-27313-11-git-send-email-peter.chen@freescale.com>
 <20131224020826.GC1128@S2101-09.ap.freescale.net>
 <20131224013446.GB13518@shlinux1.ap.freescale.net>
 <20131224022516.GD1128@S2101-09.ap.freescale.net>
 <20131224020916.GC13518@shlinux1.ap.freescale.net>
Message-ID: <20131224025433.GE1128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 10:09:17AM +0800, Peter Chen wrote:
> > Yes.  And with the DTS change being optional to kernel driver, the DTS
> > and driver changes can be merged independently through two trees.  So
> > I just applied those two DTS patches.
> > 
> 
> Including doc update or not?

No.  The binding should go with driver changes.

Shawn
