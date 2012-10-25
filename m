From: davem@davemloft.net (David Miller)
Date: Wed, 24 Oct 2012 23:06:48 -0400 (EDT)
Subject: [PATCH 1/4] net: mvneta: driver for Marvell Armada 370/XP
 network unit
In-Reply-To: <1351011300-26964-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351011300-26964-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351011300-26964-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121024.230648.1888101216213031807.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Tue, 23 Oct 2012 18:54:57 +0200

> +	u32 cause_rx_tx[CONFIG_NR_CPUS];

Please use per-cpu variables instead of explicitly sized
arrays.
