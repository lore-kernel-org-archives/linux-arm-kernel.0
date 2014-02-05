From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 5 Feb 2014 01:25:36 -0500
Subject: [RFC/PATCH] ARM: dove: Remove UBI support from defconfig
In-Reply-To: <1390829189-25073-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390829189-25073-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140205062536.GT8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 27, 2014 at 10:26:29AM -0300, Ezequiel Garcia wrote:
> As NAND support is not enabled by default, it's hard to see
> why we'd want to have UBI support. Let's remove it.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/configs/dove_defconfig | 1 -
>  1 file changed, 1 deletion(-)

Added to mvebu/defconfig

thx,

Jason.
