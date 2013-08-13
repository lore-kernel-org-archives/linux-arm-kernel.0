From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 Aug 2013 10:30:30 +0200
Subject: [PATCH 4/9] PCI: mvebu: add support for reset on GPIO
In-Reply-To: <20130813080956.GE9316@ulmo>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376333215-12885-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130813080956.GE9316@ulmo>
Message-ID: <20130813103030.1e4156a1@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Thierry Reding,

On Tue, 13 Aug 2013 10:09:56 +0200, Thierry Reding wrote:

> > +- reset-gpios: optional gpio to PERST#
> > +- reset-delay-ms: delay in ms to wait after reset de-assertion
> 
> I remember some recent discussion about this, and we now have this reset
> framework, so perhaps it makes more sense to use the reset binding for
> this? Cc'ing Stephen (as part of the device tree bindings maintainers
> team) who was involved in that recent reset bindings discussion.

I also thought about this, but the reset framework seems to be designed
for "reset controller" IPs, i.e special IPs that are controlling reset
signals. Looking at Documentation/devicetree/bindings/reset/reset.txt,
I'm not sure to see how this would apply to GPIO-controlled reset
signals.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
