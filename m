From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Jul 2014 15:43:22 +0800
Subject: [PATCH] arm/mach-imx/iomux: Do not export symbol without public
 declaration
In-Reply-To: <1406185521-30803-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1406185521-30803-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <20140729074320.GC24750@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 09:05:21AM +0200, Alexander Stein wrote:
> The iomux function declarations are in headers only accessible in this
> directory. Thus those can't be used in any module. None of the
> objects in this directory is tristate. Neither can the header be included
> in out-of-tree modules.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>

Changed patch prefix to 'ARM: imx: iomux: ...' and applied the patch.

Shawn
