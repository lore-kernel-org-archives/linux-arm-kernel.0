From: greg@kroah.com (Greg KH)
Date: Fri, 8 Jul 2011 14:36:04 -0700
Subject: [PATCH] tty/serial: tegra: Use engineering names in DT
	compatible property
In-Reply-To: <1309896461-21976-1-git-send-email-swarren@nvidia.com>
References: <1309896461-21976-1-git-send-email-swarren@nvidia.com>
Message-ID: <20110708213604.GB31866@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 02:07:41PM -0600, Stephen Warren wrote:
> Engineering names are more stable than marketing names. Hence, use them
> for Device Tree compatible properties instead.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Greg, This builds on patches Grant has (or has said he will have) in his
> devicetree/next branch, so I assume this change would be merged through
> the same route.

Sounds reasonable.  Grant, feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
to the patch when you apply it.

thanks,

greg k-h
