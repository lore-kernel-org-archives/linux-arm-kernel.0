From: chauveau.julien@gmail.com (Julien Chauveau)
Date: Wed, 16 Mar 2016 22:55:44 +0100
Subject: [PATCH v4 5/8] arm64: dts: rockchip: Clean up gpio-keys nodes
In-Reply-To: <1458136727-32075-6-git-send-email-afaerber@suse.de>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
 <1458136727-32075-6-git-send-email-afaerber@suse.de>
Message-ID: <27950358-06A9-4D97-8747-C32F56B73F11@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

> Le 16 mars 2016 ? 14:58, Andreas F?rber <afaerber@suse.de> a ?crit :
> 
> Drop superfluous #address-cells and #size-cells.
> Use KEY_POWER define for 116.
> Rename sub-nodes to avoid new dtc warnings.
> 
> Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
> Cc: Julien Chauveau <chauveau.julien@gmail.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---

It looks good to me.

Reviewed-by: Julien Chauveau <chauveau.julien@gmail.com>
