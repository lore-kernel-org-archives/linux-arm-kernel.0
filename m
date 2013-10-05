From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 5 Oct 2013 15:37:11 +0200
Subject: [PATCH] ARM: sun6i: Fix the APB2 clock gates register size
In-Reply-To: <1380121080-9321-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1380121080-9321-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20131005133711.GB3106@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 05:58:00PM +0300, Maxime Ripard wrote:
> The APB2 clocks gates are only a 32 bits register wide, and not 2 as set
> currently in the DTSI.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied to my sunxi/fixes-for-3.12 branch.

Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131005/115a6da2/attachment.sig>
