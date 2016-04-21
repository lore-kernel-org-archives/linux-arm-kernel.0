From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2016 10:44:35 +0200
Subject: [PATCH v2 11/11] arm/configs: Add aspeed defconfig
In-Reply-To: <1461225849-28074-12-git-send-email-joel@jms.id.au>
References: <1461225849-28074-1-git-send-email-joel@jms.id.au>
 <1461225849-28074-12-git-send-email-joel@jms.id.au>
Message-ID: <5382813.T3XIpjNGUQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 17:34:09 Joel Stanley wrote:
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/configs/aspeed_g4_defconfig | 86 +++++++++++++++++++++++++++++++++++
>  arch/arm/configs/aspeed_g5_defconfig | 88 ++++++++++++++++++++++++++++++++++++
> 

Please also add all drivers you need to multi_v5_defconfig. Unfortunately
we haven't come up with a good plan for a multi_v6_defconfig that allows
us to also have a combined v6+v7 config, so that doesn't exist at this time.

	Arnd
