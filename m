From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 09:39:25 +0200
Subject: [GIT PULL 7/7] omap mailbox move to drivers for v3.11 merge window
In-Reply-To: <37C860A02101E749A747FA2D3C1E3C504CD3DD@DLEE11.ent.ti.com>
References: <0MFrZm-1V3qHW1bmA-00EJsa@mx.kundenserver.de>
 <201306202146.27093.arnd@arndb.de>
 <37C860A02101E749A747FA2D3C1E3C504CD3DD@DLEE11.ent.ti.com>
Message-ID: <201306210939.26007.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Anna, Suman wrote:
> Yes, we still have a plan for a generic subsystem, and these would form the
> the base patches of OMAP adaptation towards that. OMAP mailbox was disabled
> since couple of releases now because of the multi-platform enablement. There were
> couple of different work-items needed on OMAP mailbox like fixing the multi-platform,
> converting to DT and adapting to the new framework. The previous subsystem was
> derived of the OMAP mailbox, so the first and last items were kinda automatic. The
> newest one based on Jassi's work is not gonna reuse any OMAP stuff, so this series
> handles the first one to avoid a huge pending patchset for OMAP on the generic
> framework finalization.

Ok, thanks for the explanation. Please also see the other email thread
about the linux-next conflict.

	Arnd
