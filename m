From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Mar 2012 10:31:17 -0700
Subject: [PATCH 0/6] ARM: OMAP3+: smartreflex: add class support
In-Reply-To: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
References: <1331634381-31436-1-git-send-email-j-pihet@ti.com>
Message-ID: <20120313173117.GM12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* jean.pihet at newoldbits.com <jean.pihet@newoldbits.com> [120313 03:29]:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Add the class support so that various classes of operation can be
> implemented (class 1p5 etc.).
> 
> Based on linux-omap's master branch (3.3.0-rc6), commit
> 85244e0edd240da2004bb2ab7cbcbc67a336f20d

We need to move smartreflex into drivers before adding
anything new to it.

Tony
