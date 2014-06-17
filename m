From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Jun 2014 15:31:12 +0100
Subject: [PATCH] ASoC: MMP audio needs sram support
In-Reply-To: <4367111.vzeoBg4u5h@wuerfel>
References: <4367111.vzeoBg4u5h@wuerfel>
Message-ID: <20140617143112.GQ5099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 05, 2014 at 12:40:04PM +0200, Arnd Bergmann wrote:
> From e7a94bb7fb871c73cc85712d89c1f48d0271c1be Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Thu, 5 Jun 2014 12:31:28 +0200
> Subject: [PATCH] ASoC: MMP audio needs sram support
> 
> Building the pxa/mmp audio driver without support for the mmp
> sram driver enabled results in this link error:

One other thing here: please send patches in the format in
SubmittingPatches so that the tools can apply them cleanly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140617/df72168c/attachment.sig>
