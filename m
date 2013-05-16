From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 16 May 2013 11:28:27 -0400
Subject: [PATCH] ARM: dove: declare all device IDs for module loading
In-Reply-To: <20130516131233.30145f82@armhf>
References: <20130516131233.30145f82@armhf>
Message-ID: <20130516152827.GE6563@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean-Francois,

Thanks for the patch, but you may want to change the subject "clk:
si5351: ..."  Other than that,

On Thu, May 16, 2013 at 01:12:33PM +0200, Jean-Francois Moine wrote:
> When the si5351 driver is a kernel module, it is loaded into memory
> from its i2c device IDs, but not from its DT compatible properties.
> 
> This patch declares the i2c device IDs of all chip variants.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> --- 
>  drivers/clk/clk-si5351.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>
