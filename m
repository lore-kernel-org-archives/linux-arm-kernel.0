From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 8 Jan 2014 16:19:56 +0100
Subject: [PATCH 2/2] ARM: tegra: enable LCD panel on Ventana
In-Reply-To: <1389138437-4686-2-git-send-email-swarren@wwwdotorg.org>
References: <1389138437-4686-1-git-send-email-swarren@wwwdotorg.org>
 <1389138437-4686-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140108151953.GF21974@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 04:47:17PM -0700, Stephen Warren wrote:
[...]
> @@ -581,6 +604,16 @@
>  		};
>  	};
>  
> +	panel: panel {
> +		compatible = "chungwa,claa101wa01a", "simple-panel";

This also needs "chunghwa" rather than "chungwa". With that fixed:

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/606b9cf6/attachment.sig>
