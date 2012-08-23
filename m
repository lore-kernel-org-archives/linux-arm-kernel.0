From: koen@dominion.thruhere.net (Koen Kooi)
Date: Thu, 23 Aug 2012 16:13:48 +0200
Subject: [PATCH v3 4/4] arm/dts: Add tps65217 regulator DT data to
 am335x-bone.dts
In-Reply-To: <1345547850-29761-5-git-send-email-anilkumar@ti.com>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com>
 <1345547850-29761-5-git-send-email-anilkumar@ti.com>
Message-ID: <A823657F-0D26-429F-8E1C-DF1AE5AB78F4@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 21 aug. 2012, om 13:17 heeft AnilKumar Ch <anilkumar@ti.com> het volgende geschreven:

> Add tps65217 regulator device tree data to AM335x-Bone by adding
> regulator consumers with tightened constraints and regulator-name.
> TPS65217 regulator handle can be obtained by using this regulator
> name.
> 
> This patch also add I2C node with I2C frequency and tps65217 PMIC
> I2C slave address.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>

I tried this and the kernel immediately crashes on my beaglebone. Could you upload the complete git tree and .config you used to test this to somewhere public please?
