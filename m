From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Feb 2011 09:05:14 -0800
Subject: [PATCH 2/8] OMAP4: hwmod data: Add McSPI
In-Reply-To: <1297938289-8678-3-git-send-email-b-cousson@ti.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
	<1297938289-8678-3-git-send-email-b-cousson@ti.com>
Message-ID: <20110217170514.GS20795@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Noticed one cosmetic thing below.

* Benoit Cousson <b-cousson@ti.com> [110217 02:23]:
> Update omap4 hwmod file with McSPI info.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
  ^^^ That should not be here, it shows up in your commit.

> [b-cousson at ti.com: Remove dev_attr to prevent dependency
> with device code. It will have to be re-added along with
> the original series]

As the above should be part of the commit too. Care to
refresh your branch for that?

Regards,

Tony
