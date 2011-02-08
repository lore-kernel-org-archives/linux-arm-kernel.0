From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 8 Feb 2011 09:32:00 +0100
Subject: [PATCH] arm: Use generic accessor in irq_set_flags()
In-Reply-To: <alpine.LFD.2.00.1102072349050.31804@localhost6.localdomain6>
References: <alpine.LFD.2.00.1102072349050.31804@localhost6.localdomain6>
Message-ID: <20110208083200.GJ27982@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mon, Feb 07, 2011 at 11:56:47PM +0100, Thomas Gleixner wrote:
> The generic irq code provides an accessor function to manipulate
> status flags in the irq descriptor. Replace the open coded variant.
> 
> Neccecary to let the core code rearrange the internal representation.
s/Neccecary/Necessary/

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
