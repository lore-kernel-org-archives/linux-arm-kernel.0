From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Sep 2012 14:36:54 -0700
Subject: [PATCH] ARM: add v7 multi-platform defconfig
In-Reply-To: <1348774765-9420-1-git-send-email-robherring2@gmail.com>
References: <1348774765-9420-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120929213654.GL12999@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 27, 2012 at 02:39:25PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Add a v7 defconfig enabling highbank, socfpga, mvebu, and vexpress
> platforms and their drivers. Most other options are left to the default.
> 
> The existing individual platform defconfigs are kept for now as they are
> a bit different. In some cases, the choices look pretty arbitrary and
> just copied from other defconfigs.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Dinh Nguyen <dinguyen@altera.com>
> Cc: Pawel Moll <pawel.moll@arm.com>

Thanks, applied on to of the multplatform branch now.


> I'm not sure I have all needed drivers enabled for all platforms, so please
> test and give feedback on other drivers that should be enabled.
> 
> There's a couple of fixes needed to build. The branch is available here:
> 
> git://sources.calxeda.com/kernel/linux.git defconfig

Looks like we've received one of them already (the mvebu one), and the sata fix
should go through libata.


-Olof
