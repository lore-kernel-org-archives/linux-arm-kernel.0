From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 18 May 2017 09:43:48 +0200
Subject: [PATCH] ARM: sun8i: v3s: fix build of Lichee Pi Zero Dock dtb
In-Reply-To: <20170518025332.55769-1-icenowy@aosc.io>
References: <20170518025332.55769-1-icenowy@aosc.io>
Message-ID: <20170518074348.qa74i5nn6olszptx@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 10:53:32AM +0800, Icenowy Zheng wrote:
> The Lichee Pi Zero Dock dtb file is not added to the Makefile, so that
> it won't be built; and the file contains a problem that prevents it
> from being correctly built.
> 
> Fix these issues.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

I squashed it into the previous patch, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170518/b315394e/attachment.sig>
