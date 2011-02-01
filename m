From: post@hendrik-sattler.de (Hendrik Sattler)
Date: Tue, 01 Feb 2011 10:38:30 +0100
Subject: [PATCH v2 2/6] arm/dt: Allow CONFIG_OF on ARM
In-Reply-To: <20110131210400.15105.70374.stgit@localhost6.localdomain6>
References: <20110131203626.15105.64302.stgit@localhost6.localdomain6>
	<20110131210400.15105.70374.stgit@localhost6.localdomain6>
Message-ID: <20110201103830.19083l8sqoyibqf4@v1539.ncsrv.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zitat von "Grant Likely" <grant.likely@secretlab.ca>:
> +config USE_OF
> +	bool "Flattened Device Tree support"
> +	select OF
> +	select OF_EARLY_FLATTREE
> +	help
> +	  Include support for flattened device tree machine descriptions.
> +

Arm doesn't have something called OpenFirmware, still new config  
entries that refer to that name are added. Why no keep _one_ name for  
what you add? I find the random mix of "OF" and "Device Tree" rather  
confusing.

HS
