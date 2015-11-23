From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 24 Nov 2015 00:26:03 +0100
Subject: [PATCH 1/4] component: remove old add_components method
In-Reply-To: <E1a0tZd-0006ER-PI@rmk-PC.arm.linux.org.uk>
References: <20151123160210.GR8644@n2100.arm.linux.org.uk>
 <E1a0tZd-0006ER-PI@rmk-PC.arm.linux.org.uk>
Message-ID: <20151123232603.GB22339@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2015 at 04:02:37PM +0000, Russell King wrote:
> Now that drivers create an array of component matches at probe time, we
> can retire the old methods.  This involves removing the add_components
> master method

Hi Russell

Ack for removing this. I'm using components while restructing DSA, and
it seems odd that if i don't have any optional matches this method
gets called, but if i do have matches, it does not...

     Andrew
