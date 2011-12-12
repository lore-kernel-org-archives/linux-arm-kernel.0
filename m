From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 12 Dec 2011 18:10:43 +0100
Subject: [PATCH V2] mfd: Fixed mixed up ADC single channel readout
In-Reply-To: <20111212171243.GQ13952@sortiz-mobl>
References: <1322479247-13318-1-git-send-email-robin@protonic.nl>
 <20111212171243.GQ13952@sortiz-mobl>
Message-ID: <20111212171043.GC4585@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 06:12:43PM +0100, Samuel Ortiz wrote:
> Hi Robin,
> 
> On Mon, Nov 28, 2011 at 12:20:47PM +0100, Robin van der Gracht wrote:
> > In single channel mode, when reading the ADC result, the index value
> > is still set to the channel selected for this reading.
> > This mixes up the order of the values returned. This causes problems when
> > the converted results are made available in pairs (i.e. battery current reading)
> > To straighten this up, the index value needs to be reset, so that the
> > converted values are read at the assigned channel.
> > 
> > Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> I'm not familiar with the HW, so I'd need Uwe's ACK here.
Off-hand I don't understand that patch. David, I assume you understood
the patch and are OK with it? That would be enough for me.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
