From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 Jul 2011 00:42:32 -0600 (MDT)
Subject: [PATCH v2 2/6] OMAP4: ID: add omap_has_feature for max freq
	supported
In-Reply-To: <1309573826-10615-3-git-send-email-rnayak@ti.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com>
	<1309573826-10615-2-git-send-email-rnayak@ti.com>
	<1309573826-10615-3-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1107080041150.24181@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2 Jul 2011, Rajendra Nayak wrote:

> From: Aneesh V <aneesh@ti.com>
> 
> Macros for identifying the max frequency supported by various
> OMAP4 variants - Expanding along the lines of OMAP3's feature
> handling.
> 
> [nm at ti.com: minor fixes for checks that should only for 443x|446x]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Aneesh V <aneesh@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

The use of the id.c 'features' code to specify MPU speed limits doesn't 
look right to me, but I don't have a better solution in mind at the 
moment, so:

Reviewed-by: Paul Walmsley <paul@pwsan.com>


- Paul
