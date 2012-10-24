From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 21:26:29 +0200
Subject: [PATCH 0/9] ARM: Kirkwood: Convert to pinctrl
In-Reply-To: <20121024153502.GH11837@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <CAMW5UfaHZE2VB5Ug-5hT_29U8zfO_qZh9T=9QBbx0xv7D+OeOA@mail.gmail.com>
 <20121024153502.GH11837@lunn.ch>
Message-ID: <20121024212629.272f29f6@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Wed, 24 Oct 2012 17:35:02 +0200, Andrew Lunn wrote:

> I've been testing with is:
> 
> make kirkwood_defconfig
> make 
> 
> The _defconfig file now contains all boards and should build most
> common drivers to get the boards booted. If something critical is
> missing for your boards, please let us known and we will add it to
> _defconfig.

Are you sure you don't need to add a

	select PINCTRL

in the CONFIG_ARCH_KIRKWOOD symbol?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
