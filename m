From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Aug 2012 11:46:58 +0000
Subject: [PATCH] arm/dts: AM33XX: Set the default status of module to
 "disabled" state
In-Reply-To: <1344252544-26130-1-git-send-email-hvaibhav@ti.com>
References: <1344252544-26130-1-git-send-email-hvaibhav@ti.com>
Message-ID: <201208061146.58753.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 August 2012, Vaibhav Hiremath wrote:
> Ideally in common SoC dtsi file we should set all modules
> to "disabled" state and it should get enabled in respective
> EVM/Board dts file as per usage.
> 
> This patch sets default status of all modules to "disabled"
> state in am33xx.dtsi file, and as per board requirement, enabled
> in board dts file (like, bone, evm, etc...).
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> CC: Tony Lindgren <tony@atomide.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
