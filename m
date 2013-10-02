From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 2 Oct 2013 13:48:32 -0400
Subject: [PATCH] ARM: mvebu: config: Add GPIO connected LEDs support to
 defconfig
In-Reply-To: <1380483615-15899-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380483615-15899-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131002174832.GR31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 04:40:15PM -0300, Ezequiel Garcia wrote:
> Almost every mvebu board has at least one LED connected to a GPIO
> line. Include this in the default configuration.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/mvebu_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Applied to mvebu/defconfig

thx,

Jason.
