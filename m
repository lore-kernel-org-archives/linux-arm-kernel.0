From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 4 May 2014 20:23:49 -0500
Subject: [PATCH v2] ARM: sunxi: Split the various SoCs support in Kconfig
In-Reply-To: <1398726200-30362-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398726200-30362-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20140505012349.GA11606@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 04:03:20PM -0700, Maxime Ripard wrote:
> This will allow to better isolate various options, and reduce the overall
> kernel size if we're interested in only one of the SoCs.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied in sunxi/core-for-3.16

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140504/d34e8c14/attachment.sig>
