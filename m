From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 6 Jun 2016 16:17:52 +0200
Subject: [PATCH v4 2/7] binding: Make "mdio-parent-bus" property from
 mandatory to optional
In-Reply-To: <1465216900-11755-3-git-send-email-pramod.kumar@broadcom.com>
References: <1465216900-11755-1-git-send-email-pramod.kumar@broadcom.com>
 <1465216900-11755-3-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160606141752.GN2063@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2016 at 06:11:35PM +0530, Pramod Kumar wrote:
> Change "mdio-parent-bus" from mandatory section to optional
> as it won't be required by integrated MDIO multiplexer
> which has bus selection and mdio transaction generation logic,
> integrated inside.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
