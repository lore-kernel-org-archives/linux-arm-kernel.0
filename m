From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 26 Oct 2012 14:39:08 +0200
Subject: [PATCH V2 0/4] Adding SATA support for Armada 370/XP
In-Reply-To: <1351254650-26861-1-git-send-email-gregory.clement@free-electrons.com>
References: <1351254650-26861-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20121026123908.GH21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 02:30:45PM +0200, Gregory CLEMENT wrote:
> Hello,
> 
> this patch set adds the SATA support for Armada 370 and Armada XP. Few
> changes have been done since the first version by taking in account
> the comments received for the first version.
> 
> The evaluation boards for Armada 370 and Armada XP come with 2 SATA
> ports, and when both are enable the coherent pool for DMA mapping was
> too short. It was exactly the same issue that was fixed for Kirkwood
> two months ago. So I used the same fix in the first patch. Later when
> Kirkwood will be part of mach-mvebu, then this fix will be shared
> between the 2 SoCs families.
> 
> This patch set is based on 3.7-rc2 and depends one the framework clock
> support (the last version was posted last week:
> http://thread.gmane.org/gmane.linux.kernel/1375701). The git branch
> called mvebu-SATA-for-3.8 is also available at
> https://github.com/MISL-EBU-System-SW/mainline-public.git.

Hi Gregory

What about the openblocks-ax3?

     Andrew
