From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Mar 2015 15:34:02 -0700
Subject: [PATCH] ARM: sunxi: DT: Add stdout-path property
In-Reply-To: <1426448851-32204-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1426448851-32204-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150324223402.GF23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 15, 2015 at 08:47:31PM +0100, Maxime Ripard wrote:
> Add UART aliases and stdout-path property for all the Allwinner boards so that
> we won't have to rely on the bootargs' console= value, while working with
> legacy bootloaders.
> 
> While we're at it, also remove the mentions of earlyprintk in the bootargs,
> that will remove our default bootargs entirely, and allow the kernel to boot on
> a system even if DEBUG_LL is configured for another system.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/50f8315b/attachment.sig>
