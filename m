From: balbi@ti.com (Felipe Balbi)
Date: Mon, 11 Feb 2013 17:49:47 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: Allow clock alias provision from device
 tree
In-Reply-To: <1360597464-8491-1-git-send-email-rogerq@ti.com>
References: <1360597464-8491-1-git-send-email-rogerq@ti.com>
Message-ID: <20130211154947.GA18684@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 11, 2013 at 05:44:23PM +0200, Roger Quadros wrote:
> @@ -36,12 +39,76 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
>  	{ }
>  };
>  
> +static int __init omap_create_clk_alias(struct device_node *np)

if the rest of the folks agree with the aproach, looks like most of this
can be made a bit more generic ;-)


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130211/c3d895fc/attachment.sig>
