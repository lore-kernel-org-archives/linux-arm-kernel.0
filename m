From: julien.chauveau@neo-technologies.fr (NEO-Technologies / Julien CHAUVEAU)
Date: Mon, 27 Oct 2014 09:02:57 +0100
Subject: [PATCH] ARM: dts: rockchip: use internal pull-up resistors on
 I2C busses
In-Reply-To: <8843018.dv9ckEkBvo@diego>
References: <1413556830-27854-1-git-send-email-julien.chauveau@neo-technologies.fr>
 <8843018.dv9ckEkBvo@diego>
Message-ID: <544DFC31.4090307@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Le 27/10/2014 01:27, Heiko St?bner a ?crit :
> The rk3066a does not support distinguishing between up and down pulls. On it
> only &pcfg_pull_default is possible that configures the pull to a pin-specific
> pull direction. For the i2c pins the direction is (of course) "up".

Thank you for the information. I will send a new patch to fix the pull 
configuration for the rk3066a.

Julien
