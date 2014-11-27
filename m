From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Nov 2014 22:52:10 +0100
Subject: [PATCH 2/3] ARM: edma: Rename header file for dmaengine filter
 function definition
In-Reply-To: <54777174.4070203@ti.com>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
 <3300340.ou8f7H2hIc@wuerfel> <54777174.4070203@ti.com>
Message-ID: <4859328.eEV7jzKEaA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 November 2014 20:46:12 Peter Ujfalusi wrote:
> 
> I see. With this series I did not planed to fix all edma related issues, just
> as a start clean up the related header files. I would rather not add fixes to
> mmc, spi, etc drivers since while you have valid point it is not in the scope
> of this series.
> Can we do the changes you are suggesting in an incremental manner?

Sure, but I'd leave the existing filter function declaration alone then
and not move it, since we wouldn't want to keep it in the long run.

	Arnd
