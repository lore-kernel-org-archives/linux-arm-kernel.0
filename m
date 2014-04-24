From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 24 Apr 2014 17:50:41 +0800
Subject: [PATCH 1/6] ata: ahci: add AHCI support for Berlin SoCs
In-Reply-To: <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398181105-19714-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140424175041.0bade2d6@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Tue, 22 Apr 2014 08:38:20 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

> +		/* CT timing fix */
> +		ahci_berlin_reg_set(ctrl_reg + PORT_VSR_ADDR, BIT(6) |
> BIT(1));
> +		ahci_berlin_reg_set(ctrl_reg + PORT_VSR_ADDR,
> +				    BIT(15) | BIT(13) | BIT(12) | BIT(11) |
> +				    BIT(10) | BIT(2) | BIT(1));

Could you please remove these code? They are not used for BG2Q, I'm sorry there's
such mistake in the code I provided to you ;)

Thanks
