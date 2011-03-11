From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 11 Mar 2011 13:15:20 +0000
Subject: [PATCH 8/8] macb: support data bus widths > 32 bits
In-Reply-To: <20110311125523.GN9351@game.jcrosoft.org>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-9-git-send-email-jamie@jamieiles.com>
	<20110311125523.GN9351@game.jcrosoft.org>
Message-ID: <20110311131520.GC7357@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2011 at 01:55:23PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:10 Thu 10 Mar     , Jamie Iles wrote:
> > Some GEM implementations may support data bus widths up to 128 bits.
> > Allow the platform data to specify the data bus width and let the driver
> > program it up.
> > 
> can we detect it?

Well, the first design configuration register will tell you what the 
maximum data bus width is so we could probably always go with that.  I 
can't think of a good reason why you wouldn't want to do that.

Jamie
