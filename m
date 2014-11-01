From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 1 Nov 2014 19:11:20 -0400
Subject: [PATCH v2 4/4] ARM: mvebu: Enable the reference clock for
 timer and watchdog on Armada 375 SoC
In-Reply-To: <1414248522-16055-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1414248522-16055-5-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20141101231120.GK3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 25, 2014 at 11:48:42AM -0300, Ezequiel Garcia wrote:
> Now that the timer and watchdog drivers support the Armada 375 usage of
> the reference clock, we can enable it in the devicetree.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-375.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Applied to mvebu/dt with a Reviewed-by and a Tested-by from Thomas.

thx,

Jason.
