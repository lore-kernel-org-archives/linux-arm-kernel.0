From: rogershimizu@gmail.com (Roger Shimizu)
Date: Tue, 21 Jul 2015 19:02:31 +0900
Subject: [PATCH 2/2] ARM: defconfig: add DT support for orion5x_defconfig
In-Reply-To: <20150720204748.GB21011@lunn.ch>
References: <1436878802-25712-1-git-send-email-rogershimizu@gmail.com>
 <1436878802-25712-3-git-send-email-rogershimizu@gmail.com>
 <20150720204748.GB21011@lunn.ch>
Message-ID: <CAEQ9gE=K8ji7nJoQ6f-bRX7obpRf8o1VHhau-BrUY5SUN0G2rA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew,

Thanks for your feedback!

For config of "EARLY_PRINTK" and "NETCONSOLE", I understand your
concern and I'll remove them.
However, I want to add another one, which I find it necessary to boot
on my orion5x hardware:

CONFIG_ARM_ATAG_DTB_COMPAT=y

I need this because the uboot is quite old on that orion5x board and
the only way to add DT support is to append the DTB at the end of
zImage.
I guess other orion5x boards might be the same situation, so this
config had better go into "orion5x_defconfig".
Let me know your opinion. Thank you!

Cheers,
Roger
