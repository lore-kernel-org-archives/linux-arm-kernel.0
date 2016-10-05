From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 5 Oct 2016 17:28:37 +0200
Subject: [PATCH] arm64: dts: marvell: Add definition for the Globalscale
 Marvell ESPRESSOBin Board
In-Reply-To: <87fuoaygie.fsf@free-electrons.com>
References: <20161005142734.18995-1-romain.perier@free-electrons.com>
 <87fuoaygie.fsf@free-electrons.com>
Message-ID: <20161005172837.5ea130a1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 05 Oct 2016 17:14:49 +0200, Gregory CLEMENT wrote:

> > +	memory {
> > +		device_type = "memory";  
> 
> 
> According to the kickstarter page the boards will came with different
> amount of memory (from 512MB to 2GB). So we could put a comment
> here about tuning this value depending of the board.

U-Boot does this tuning automatically, so there is no need for the user
to tune anything here.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
