From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 28 Jul 2018 02:03:03 +0200
Subject: [PATCH v2 6/7] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <20180728000303.GA23816@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  static void mdio_mux_iproc_config(struct iproc_mdiomux_desc *md)
>  {
>  	u32 val;
> +	u32 divisor;

Hi Arun

Reverse Christmas tree please.

	Andrew
