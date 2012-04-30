From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 30 Apr 2012 18:51:56 +0200
Subject: Tegra board file deprecation schedule
In-Reply-To: <4F9EB68A.3080309@wwwdotorg.org>
References: <4F9B0E7C.1060408@wwwdotorg.org> <2573129.rORKuOVVxu@fb07-iapwap2>
 <4F9EB68A.3080309@wwwdotorg.org>
Message-ID: <6157937.A8jHT3QHt6@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 April 2012 09:58:02 Stephen Warren wrote:
> On 04/30/2012 02:58 AM, Marc Dietrich wrote:
> > Am Sonntag, 29. April 2012, 13:16:38 schrieb Stephen Warren:
> ...
> 
> >> The correct approach here is to remove all the I2C logic from the NVEC
> >> driver and add I2C slave support to the real I2C driver. Then, NVEC
> >> becomes just a protocol driver for the slave transactions. Then, there
> >> is no clock to deal with.
> > 
> > you are absolutely right, but there is no i2c slave controller driver in
> > mainline yet and I don't want to submit the one nvidia already wrote [1].
> > Maybe you can ask around if someone is willing to do this.
> 
> Someone has been assigned to work on this, but other priorities are in
> the way. Unfortunately, I don't have any realistic ETA I can give right now.

oh, that's nice. The nvec driver is also far from perfect, so we have some 
more time to cleanup the rest.

Marc
