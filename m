From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Jan 2015 10:38:00 +0100
Subject: [PATCH] ARM: sun6i: Enable ARM arch timers
In-Reply-To: <1421004824-17525-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1421004824-17525-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150119093800.GA4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 11, 2015 at 08:33:44PM +0100, Maxime Ripard wrote:
> The A31 has non-initialized architected timers, without CNTFRQ or CNTVOFF set
> by the Allwinner's bootloader.
> 
> Use the new DT property for such case, and enable the arch timers.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150119/631ef335/attachment.sig>
