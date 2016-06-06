From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 6 Jun 2016 16:17:28 +0200
Subject: [PATCH v4 1/7] mdio: mux: Enhanced MDIO mux framework for
 integrated multiplexers
In-Reply-To: <1465216900-11755-2-git-send-email-pramod.kumar@broadcom.com>
References: <1465216900-11755-1-git-send-email-pramod.kumar@broadcom.com>
 <1465216900-11755-2-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160606141728.GM2063@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 06:11:34PM +0530, Pramod Kumar wrote:
> An integrated multiplexer uses same address space for
> "muxed bus selection" and "generation of mdio transaction"
> hence its good to register parent bus from mux driver.
> 
> Hence added a mechanism where mux driver could register a
> parent bus and pass it down to framework via mdio_mux_init api.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

     Andrew
