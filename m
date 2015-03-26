From: tony@atomide.com (Tony Lindgren)
Date: Thu, 26 Mar 2015 10:50:35 -0700
Subject: [RESEND PATCH 2/2] bus: ocp2scp: SYNC2 value should be changed
 to 0x6
In-Reply-To: <1426591491-3685-2-git-send-email-kishon@ti.com>
References: <1426591491-3685-1-git-send-email-kishon@ti.com>
 <1426591491-3685-2-git-send-email-kishon@ti.com>
Message-ID: <20150326175035.GC10805@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [150317 04:25]:
> As per the TRMs of AM572x, OMAP4430, OMAP4460, OMAP543x, the value of
> SYNC2 must be set to 0x6 in order to ensure correct operation.
> 
> So modified the SYNC2 value of OCP2SCP TIMING register to 0x6 in all the
> platforms that use OCP2SCP driver except AM437x. Also introduced a new
> compatible property since we don't want to modify the OCP2SCP TIMING
> register for AM437x.

OK thanks I'll apply both into omap-for-v4.1/fixes-not-urgent as
it seems we've gotten away with it for quite a few years now, and
I don't see any specific description of what these fix.

If that's not the case, please let me know.

Regards,

Tony
