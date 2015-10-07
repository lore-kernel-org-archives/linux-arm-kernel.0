From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Oct 2015 21:37:04 +0200
Subject: [PATCH] ARM: configs: keystone: Add ramdisk support
In-Reply-To: <1444246089-1417-1-git-send-email-nm@ti.com>
References: <1444246089-1417-1-git-send-email-nm@ti.com>
Message-ID: <12772658.mmM2ZKnfR4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 October 2015 14:28:09 Nishanth Menon wrote:
> Add ramdisk support to allow for minimal kernel to be supported.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> 

I have not seen that in a while. Can you explain why the normal
initramfs method doesn't work on keystone?

	Arnd
