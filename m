From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 02 Sep 2014 09:08:34 -0600
Subject: [PATCH] ARM: configs: Remove REGULATOR_VIRTUAL_CONSUMER from
 defconfigs
In-Reply-To: <1409486590-23645-1-git-send-email-broonie@kernel.org>
References: <1409486590-23645-1-git-send-email-broonie@kernel.org>
Message-ID: <5405DD72.30603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2014 06:03 AM, Mark Brown wrote:
> The virtual consumer is a test device intended to be used while developing
> regulator drivers, it should never be used in production. Remove it from
> all defconfigs to avoid confusion among users.

tegra_defconfig isn't a distro configuration, and has plenty of other 
debug/test options turned on. I'm not sure that removing this option 
really has much benefit. Still, this likely isn't going to cause any 
issue, so I guess it's fine. People can always add the option locally if 
they want.
