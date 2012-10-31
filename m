From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 31 Oct 2012 06:38:50 +0000 (UTC)
Subject: [PATCH 05/13] ARM: OMAP2+: PRCM: create SoC-specific chip restart
 functions
In-Reply-To: <5090C6B5.3080407@ti.com>
References: <20121025231818.17558.57884.stgit@dusk.lan>
 <20121025232116.17558.47458.stgit@dusk.lan> <5090C6B5.3080407@ti.com>
Message-ID: <alpine.DEB.2.00.1210310638280.8340@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Oct 2012, Vaibhav Hiremath wrote:

> omap5xxx_restart declaration needs to be removed from here.
> There is no such function implemented in code.

Thanks, prototype dropped.


- Paul
