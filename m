From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Mar 2012 17:59:19 +0000
Subject: [PATCH 5/5] MMC: mmci: Add required documentation for Device
 Tree bindings
In-Reply-To: <201203151753.25774.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <1331734803-17954-6-git-send-email-lee.jones@linaro.org>
 <201203151753.25774.arnd@arndb.de>
Message-ID: <20120315175919.GI15988@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 05:53:25PM +0000, Arnd Bergmann wrote:
> On Wednesday 14 March 2012, Lee Jones wrote:
> > +
> > +Optional properties:
> > +- ocr_mask               : contains the regulator oscillator mask
> 
> Not sure about this one. If it's for the regulators, we should be
> using the regulator bindings.

It's also nothing to do with oscillators.
