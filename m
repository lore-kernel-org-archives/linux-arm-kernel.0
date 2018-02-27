From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Feb 2018 09:17:21 +0100
Subject: [PATCH 1/4] dt-bindings: arm: Document SoC compatible value for
 Armadillo-800 EVA
In-Reply-To: <1519668225-12548-2-git-send-email-geert+renesas@glider.be>
References: <1519668225-12548-1-git-send-email-geert+renesas@glider.be>
 <1519668225-12548-2-git-send-email-geert+renesas@glider.be>
Message-ID: <20180227081720.ejxqgr5zbufxkfmi@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 07:03:42PM +0100, Geert Uytterhoeven wrote:
> The compatible property of the root node in a DTS for Atmark Techno
> Armadillo-800 EVA should include the compatible value for the R-Mobile
> A1 SoC, too.
> 
> Fixes: d2c2a0776899ba2d ("ARM: shmobile: Add platform device tree bindings documentation")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
