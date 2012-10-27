From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 27 Oct 2012 02:51:16 +0000 (UTC)
Subject: [PATCHv9 6/8] ARM: OMAP4: retrigger localtimers after re-enabling
 gic
In-Reply-To: <1350552010-28760-7-git-send-email-t-kristo@ti.com>
References: <1350552010-28760-1-git-send-email-t-kristo@ti.com>
 <1350552010-28760-7-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1210270250140.27071@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 18 Oct 2012, Tero Kristo wrote:

> From: Colin Cross <ccross@android.com>
> 
> 'Workaround for ROM bug because of CA9 r2pX gic control'
> register change disables the gic distributor while the secondary
> cpu is being booted.  If a localtimer interrupt on the primary cpu
> occurs when the distributor is turned off, the interrupt is lost,
> and the localtimer never fires again.

Looks like this one should go in separately via Tony.


- Paul
