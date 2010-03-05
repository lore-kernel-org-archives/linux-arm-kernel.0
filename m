From: Colin.Tuckley@arm.com (Colin Tuckley)
Date: Fri, 5 Mar 2010 12:12:33 +0000
Subject: [PATCH] ARM: Add Versatile Express SMP support
In-Reply-To: <git-1267729916-22c6a14e4a304af9afdfe1ccf493570f862ba05f@rmk-PC>
References: <git-1267729916-8545dcd13a3ae6450278b076cb024d10d64ee785@rmk-PC>
	<git-1267729916-22c6a14e4a304af9afdfe1ccf493570f862ba05f@rmk-PC>
Message-ID: <F01D8B85CFF58440B2A13965FBA90CA404E3EA536A@GEORGE.Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Russell King


> +++ b/arch/arm/mach-vexpress/headsmp.S

   <snip>

> + * Realview specific entry point for secondary CPUs.  This provides


That "Realview" is incorrect, it could either be removed or replaced with "Versatile Express"

Colin

--
Colin Tuckley - ARM Ltd.
110 Fulbourn Rd
Cambridge, CB1 9NJ
Tel: +44 1223 400536


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
