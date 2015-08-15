From: dv@vollmann.ch (Detlef Vollmann)
Date: Sat, 15 Aug 2015 22:09:55 +0200
Subject: [PATCH] ARM: orion5x: fix legacy orion5x IRQ numbers
In-Reply-To: <1439648246-32757-1-git-send-email-gregory.clement@free-electrons.com>
References: <1439648246-32757-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <55CF9C93.801@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On 08/15/15 16:17, Gregory CLEMENT wrote:
> I amended the patch from Benjamin as it break the build for
> dove. Could you test it again wit this version?
Tested with orion5x_defconfig on 4.2.0-rc6 and with my
own config on 4.1.2.
Looks good for both :-)

Thanks!
   Detlef
