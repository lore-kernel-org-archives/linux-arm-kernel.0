From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 11 Mar 2011 14:14:15 +0100
Subject: [PATCH 4/8] macb: initial support for Cadence GEM
In-Reply-To: <1299751843-9743-5-git-send-email-jamie@jamieiles.com>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-5-git-send-email-jamie@jamieiles.com>
Message-ID: <20110311131415.GO9351@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:10 Thu 10 Mar     , Jamie Iles wrote:
> The Cadence GEM is based on the MACB Ethernet controller but has a few
> small changes with regards to register and bitfield placement.  This
> patch adds a new platform driver for gem which sets allows the driver to
> tell at runtime whether it is targetting a GEM device.
> 
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
could we avoid all this if else everywhere?

Best Regards,
J.
