From: segher@kernel.crashing.org (Segher Boessenkool)
Date: Fri, 4 Nov 2011 23:15:59 +0100
Subject: [PATCH 2/4] mmc: omap: adapt the hsmmc driver to device tree
In-Reply-To: <20111104200415.GC3045@quad.lixom.net>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
	<1320407441-29697-3-git-send-email-rnayak@ti.com>
	<20111104200415.GC3045@quad.lixom.net>
Message-ID: <461DAB8E-1828-44C9-9A0B-D9C09ED9CA0A@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +ti,hsmmc-non-removable: non-removable slot (like eMMC)
>
> Same here, non-removable should be standardized.

CHRP has a "built-in" property for this.  That was standardised in 1998,
you could reuse it :-)


Segher
