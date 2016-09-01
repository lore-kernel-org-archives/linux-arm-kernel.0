From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 1 Sep 2016 14:23:29 +0200
Subject: [PATCH 1/2 v2] bus: mvebu-mbus: Provide stub function for
 mvebu_mbus_get_io_win_info()
In-Reply-To: <20160901093904.26564-1-sr@denx.de>
References: <20160901093904.26564-1-sr@denx.de>
Message-ID: <20160901122329.GA4367@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan

> +	/*
> +	 * On all ARM32 MVEBU platforms with MBus support, this stub
> +	 * function will not get called. The real function from the
> +	 * MBus driver is called instead. ARM64 MVEBU platforms like
> +	 * the Armada 3700 could do use the mv_xor device which calls

could us, or do us, but not both.

Thanks
	Andrew
