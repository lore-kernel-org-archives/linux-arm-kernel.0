From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 13 Mar 2014 19:22:31 -0400
Subject: [PATCH 1/1] clk: mvebu: Fix ratio register offset on A375 SoC
In-Reply-To: <1394638901-13368-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394638901-13368-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1394638901-13368-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140313232231.GA15608@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 12:41:41PM -0300, Ezequiel Garcia wrote:
> This commit fixes the ratio register offset which is 0x4,
> as per the Armada 375 SoC specification.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/clk/mvebu/clk-corediv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to mvebu/clk-3xx

thx,

Jason.
