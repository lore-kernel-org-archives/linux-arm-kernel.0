From: olof@lixom.net (Olof Johansson)
Date: Thu, 10 Apr 2014 21:00:50 -0700
Subject: [PATCH 12/27] ARM: dts: exynos3250: Add default interrupt-parent
 connected with GIC
In-Reply-To: <1397124377-16969-4-git-send-email-cw00.choi@samsung.com>
References: <1397122658-16013-1-git-send-email-cw00.choi@samsung.com>
 <1397124377-16969-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <20140411040050.GD14934@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 07:06:02PM +0900, Chanwoo Choi wrote:
> This patch add interrupt-parent node to connected with GIC.
> All interrupt-related dt nodes need default interrupt-parent node.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

There's no point in splitting these off in separate patches; fold them
into one patch that introduces the SoC dtsi, please.

Also, you missed your sign-off on one or two of the previous ones, but that
won't be a problem once they're folded in. :)

Finally, if the code is yours, and you're posting it, then Kyungmin should
probably have a Reviewed-by or Acked-by tag, not a Signed-off-by. See
Documentation/SubmittingPatches, section 12 and 13.

-Olof
