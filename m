From: wg@grandegger.com (Wolfgang Grandegger)
Date: Tue, 30 Mar 2010 09:23:35 +0200
Subject: [PATCH] Add hotplug support to mcp251x driver
In-Reply-To: <1269889076-5611-1-git-send-email-maz@misterjones.org>
References: <1269889076-5611-1-git-send-email-maz@misterjones.org>
Message-ID: <4BB1A6F7.1090600@grandegger.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote:
> Chip model can now be selected directly by matching the modalias name
> (instead of filling the .model field in platform_data), and allows the
> module to be auto-loaded. Previous behaviour is of course still supported.
> 
> Convert the two in-tree users to this feature (icontrol & zeus).
> Tested on an Zeus platform (mcp2515).
> 
> Signed-off-by: Marc Zyngier <maz@misterjones.org>
> Acked-by: Christian Pellegrin <chripell@fsfe.org>
> Cc: Edwin Peer <epeer@tmtservices.co.za>

Acked-by: Wolfgang Grandegger <wg@grandegger.com>

for the Socket-CAN part.

Wolfgang.
