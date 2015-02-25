From: horms@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 08:31:28 +0900
Subject: [PATCH v2] ARM: shmobile: r8a7790: Fix HSUSB clock to hp_clk
 from mp_clk
In-Reply-To: <1424360575-6482-1-git-send-email-horms+renesas@verge.net.au>
References: <1424360575-6482-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20150225233128.GH23723@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 10:42:55AM -0500, Simon Horman wrote:
> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> 
> HSUSB uses hp_clk rather than mp_clk for H/W register access.
> 
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> [horms: updated changelog]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up.
