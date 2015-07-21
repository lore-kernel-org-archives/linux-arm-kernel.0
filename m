From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 21 Jul 2015 15:07:27 +0200
Subject: [PATCH 2/2] ARM: defconfig: add DT support for orion5x_defconfig
In-Reply-To: <CAEQ9gE=K8ji7nJoQ6f-bRX7obpRf8o1VHhau-BrUY5SUN0G2rA@mail.gmail.com>
References: <1436878802-25712-1-git-send-email-rogershimizu@gmail.com>
 <1436878802-25712-3-git-send-email-rogershimizu@gmail.com>
 <20150720204748.GB21011@lunn.ch>
 <CAEQ9gE=K8ji7nJoQ6f-bRX7obpRf8o1VHhau-BrUY5SUN0G2rA@mail.gmail.com>
Message-ID: <20150721130727.GE21011@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 07:02:31PM +0900, Roger Shimizu wrote:
> Dear Andrew,
> 
> Thanks for your feedback!
> 
> For config of "EARLY_PRINTK" and "NETCONSOLE", I understand your
> concern and I'll remove them.
> However, I want to add another one, which I find it necessary to boot
> on my orion5x hardware:
> 
> CONFIG_ARM_ATAG_DTB_COMPAT=y

Hi Roger

This one is .O.K.

     Andrew
