From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 Jul 2011 00:51:05 -0600 (MDT)
Subject: [PATCH v2 6/6] OMAP4: clockdomain: Reuse on 4460 using
	CHIP_IS_44XX
In-Reply-To: <1309573826-10615-7-git-send-email-rnayak@ti.com>
References: <1309573826-10615-1-git-send-email-rnayak@ti.com>
	<1309573826-10615-2-git-send-email-rnayak@ti.com>
	<1309573826-10615-3-git-send-email-rnayak@ti.com>
	<1309573826-10615-4-git-send-email-rnayak@ti.com>
	<1309573826-10615-5-git-send-email-rnayak@ti.com>
	<1309573826-10615-6-git-send-email-rnayak@ti.com>
	<1309573826-10615-7-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1107080049240.24181@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2 Jul 2011, Rajendra Nayak wrote:

> The 4460 platform has no difference in the clockdomains as compared
> to the 4430 platform. Hence just update the .omap_chip field to make
> sure the same clockdomain data can be reused on the 4460 platform.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
