From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 10 Mar 2011 03:17:32 -0700 (MST)
Subject: [PATCH 1/2] OMAP3: cpuidle: prevent CORE power domain from going
	to RET or OFF when DSS is on
In-Reply-To: <854C6400F5AA6644BA6FE7953F3E769B0380FE45@008-AM1MPN1-013.mgdnok.nokia.com>
References: <20110301220833.32613.54669.stgit@twilight.localdomain>
	<20110301224918.32613.95176.stgit@twilight.localdomain>
	<87pqq7pz27.fsf@ti.com>
	<854C6400F5AA6644BA6FE7953F3E769B0380F12F@008-AM1MPN1-013.mgdnok.nokia.com>
	<87lj0uj048.fsf@ti.com>
	<854C6400F5AA6644BA6FE7953F3E769B0380FE45@008-AM1MPN1-013.mgdnok.nokia.com>
Message-ID: <alpine.DEB.2.00.1103100315550.15132@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero,

On Mon, 7 Mar 2011, Tero.Kristo at nokia.com wrote:

> What is the current status with those idlest patches anyway?

They aren't completed yet, so they won't make it into 2.6.39.  I hope to 
get them in early in 2.6.40.


- Paul
