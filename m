From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Jan 2018 16:38:07 +0100
Subject: [PATCH v3] ARM: dts: sun8i: NanoPi NEO Air add WiFi / eMMC
In-Reply-To: <20180123235844.5511-1-mkelly@xevo.com>
References: <20180123235844.5511-1-mkelly@xevo.com>
Message-ID: <20180125153807.dmtzly56iphnilxq@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 23, 2018 at 03:58:44PM -0800, Martin Kelly wrote:
> From: Jelle van der Waa <jelle@vdwaa.nl>
> 
> Enable the WiFi (AP6212) chip and eMMC support for the NanoPi NEO Air.
> 
> This patch was originally submitted by Jelle van der Waa. Martin Kelly
> modified it to compile on the latest kernel, fixed up some review
> comments from Maxime Ripard, and re-tested the patch.
> 
> These are the original patch submissions:
> 
> https://patchwork.kernel.org/patch/9581613/
> https://patchwork.kernel.org/patch/9642071/
> 
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: linux-sunxi at googlegroups.com
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
> Signed-off-by: Martin Kelly <mkelly@xevo.com>

I've reworked a bit the commit title and removed the links, and queued
it for 4.17.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180125/c7dfff59/attachment.sig>
