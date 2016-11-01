From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 1 Nov 2016 21:48:26 +0100
Subject: [PATCH v4 2/7] Documentation: devicetree: add PHY lane swap
 binding
In-Reply-To: <1478030682-27012-3-git-send-email-jon.mason@broadcom.com>
References: <1478030682-27012-1-git-send-email-jon.mason@broadcom.com>
 <1478030682-27012-3-git-send-email-jon.mason@broadcom.com>
Message-ID: <20161101204826.GA21010@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +- enet-phy-lane-swap: If set, indicates the PHY device requires swapping the
> +  TX/RX lanes to function properly.

Is 'requires' the right word here? The PHY performs the actual swap of
the Tx/Rx lanes.

    Andrew
