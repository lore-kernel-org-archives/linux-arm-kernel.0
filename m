From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Feb 2016 10:15:14 -0800
Subject: [PATCH] ARM: OMAP: DRA7: Make use of omap_revision information
 for soc_is* calls
In-Reply-To: <1455706123-26497-1-git-send-email-j-keerthy@ti.com>
References: <1455706123-26497-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20160219181514.GK21202@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [160217 02:49]:
> Currently of_machine_is_compatible is used to detect the soc which
> employs string comparison operations. We already have all the required
> information in the omap_revision. Hence make use of the same like
> the previous OMAPs and avoid costly string comparisons.

Looks good to me thanks. Applying into omap-for-v4.6/soc.

Tony
