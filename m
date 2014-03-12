From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Mar 2014 17:06:59 +0100
Subject: [PATCH v2 1/3] ata: ahci_st: Provide DT bindings for ST's SATA
 implementation
In-Reply-To: <20140312124835.GA22450@lee--X1>
References: <1393328481-7251-1-git-send-email-lee.jones@linaro.org>
 <20140312114257.GA17461@e106331-lin.cambridge.arm.com>
 <20140312124835.GA22450@lee--X1>
Message-ID: <7613177.7hd4IoKUr4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 March 2014 12:48:35 Lee Jones wrote:
> > > +This binding describes a SATA device.
> > > +
> > > +Required properties:
> > > + - compatible         : Must be "st,ahci"
> > 
> > Is there not a more specific name? This is awfully generic.
> 
> There isn't one. ST only have one AHCI driver. The driver is named as
> generically.

If it is this generic, can't you use the completely generic
ahci-platform driver and add a "generic-ahci" compatible string
to that?

	Arnd
