From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 11 Mar 2011 13:55:23 +0100
Subject: [PATCH 8/8] macb: support data bus widths > 32 bits
In-Reply-To: <1299751843-9743-9-git-send-email-jamie@jamieiles.com>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-9-git-send-email-jamie@jamieiles.com>
Message-ID: <20110311125523.GN9351@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:10 Thu 10 Mar     , Jamie Iles wrote:
> Some GEM implementations may support data bus widths up to 128 bits.
> Allow the platform data to specify the data bus width and let the driver
> program it up.
> 
can we detect it?

Best Regards,
J.
