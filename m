From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 Nov 2009 14:00:48 +0000
Subject: [PATCH 12/17] ARM: pxa/raumfeld: add audio related functions
In-Reply-To: <20091125135341.GE14091@buzzloop.caiaq.de>
References: <20091125122857.GJ29442@buzzloop.caiaq.de>
	<20091125130723.GA14045@rakim.wolfsonmicro.main>
	<20091125135341.GE14091@buzzloop.caiaq.de>
Message-ID: <20091125140048.GA32430@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 02:53:41PM +0100, Daniel Mack wrote:

> Ok, just to make sure I get you right: the idea would be to add a simple
> regulator and label it in a way so that the codec driver will be able
> to take control? And then claim that regulator from cs4270.c?

> I guess "reg-fixed-voltage" would be the appropriate driver?

Yes, in -next it has support for an enable GPIO.
