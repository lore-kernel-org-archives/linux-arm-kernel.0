From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 10 Feb 2011 19:10:17 -0700 (MST)
Subject: [PATCH v2 2/5] OMAP: clockdomain: Arch specific funcs to handle
	deps
In-Reply-To: <alpine.DEB.2.00.1102101840200.21991@utopia.booyaka.com>
References: <1295956308-23860-1-git-send-email-rnayak@ti.com>
	<1295956308-23860-2-git-send-email-rnayak@ti.com>
	<1295956308-23860-3-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1102101840200.21991@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1102101908540.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


One other minor change; also modified the wkdep_src/sleepdep_src clkdm 
resolve loops in clkdm_init() to avoid re-resolving clockdomains that have 
already been looked up.  Updated patch follows.


- Paul
