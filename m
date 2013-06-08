From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 8 Jun 2013 10:18:51 -0400
Subject: [PATCH 12/14] ARM: mvebu: Remove device tree unused properties
 on A370
In-Reply-To: <1370623671-7748-13-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-13-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130608141851.GY23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 01:47:49PM -0300, Ezequiel Garcia wrote:
> These properties are not needed so it's safe to remove them.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370.dtsi | 4 ----
>  1 file changed, 4 deletions(-)

Also as mentioned by Thomas, applied to mvebu/dt with his Ack.

thx,

Jason.
