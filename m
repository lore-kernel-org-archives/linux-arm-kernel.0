From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Sep 2010 14:41:05 -0700
Subject: [PATCH v4 2/4] omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS
	is not set
In-Reply-To: <9493.10.24.255.18.1285348410.squirrel@dbdmail.itg.ti.com>
References: <9493.10.24.255.18.1285348410.squirrel@dbdmail.itg.ti.com>
Message-ID: <20100928214105.GQ3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* kishore kadiyala <kishore.kadiyala@ti.com> [100924 10:05]:
> From: Benoit Cousson <b-cousson@ti.com>
> 
> Avoid possible crash if CONFIG_MMC_OMAP_HS is not set

Will queue this and patches 3/4 and 4/4 of this series
for the upcoming merge window.

Tony
