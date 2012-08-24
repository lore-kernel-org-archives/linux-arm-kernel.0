From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Aug 2012 13:07:36 -0700
Subject: [PATCH-V2] arm/dts: AM33XX: Set the default status of module
 to "disabled" state
In-Reply-To: <1345029805-27987-1-git-send-email-hvaibhav@ti.com>
References: <1345029805-27987-1-git-send-email-hvaibhav@ti.com>
Message-ID: <20120824200736.GX11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Vaibhav Hiremath <hvaibhav@ti.com> [120815 04:24]:
> Ideally in common SoC dtsi file should set all modules
> to "disabled" state and it should get enabled in respective
> EVM/Board dts file as per usage.
> 
> This patch sets default status of all modules to "disabled"
> state in am33xx.dtsi file. Currently there are no modules
> supported as part of Bone and EVM dts support, so care
> to add entry "status = "okay"" while adding support for any
> module.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
> Changes from V1:
> 	- Fixed indentation issue caused due to extra spaces.

Thanks applying into devel-dt branch.

Tony
