From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Mon, 28 Aug 2017 13:24:40 +0200
Subject: [PATCH linux-next] fix compilation error in mach-omap2/display.c
In-Reply-To: <20170828093207.GA29080@amd>
References: <20170828093207.GA29080@amd>
Message-ID: <20170828112439.47zuaxeemkqmjuof@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 28, 2017 at 11:32:07AM +0200, Pavel Machek wrote:
> In linux-next 0828, I get
> 
>   CC      arch/arm/mach-omap2/display.o
>   arch/arm/mach-omap2/display.c: In function 'omapdss_init_fbdev':
>   arch/arm/mach-omap2/display.c:184:2: error: 'r' undeclared (first
> 
> Fix it.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

https://lkml.org/lkml/2017/8/23/346

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170828/d6b169ef/attachment.sig>
