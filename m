From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Dec 2015 16:14:06 -0800
Subject: [PATCH 0/2] ARM: dts: Use MMC pwrseq instead regulators for IGEP
 WiFi init
In-Reply-To: <CAFqH_536_sG7fju=u39aMKmzXt8KDCxU1-dFM03H060zbh5qxw@mail.gmail.com>
References: <1449165729-993-1-git-send-email-javier@osg.samsung.com>
 <20151203181624.GW23396@atomide.com>
 <566089E1.7050805@osg.samsung.com>
 <20151203192719.GZ23396@atomide.com>
 <CAFqH_536_sG7fju=u39aMKmzXt8KDCxU1-dFM03H060zbh5qxw@mail.gmail.com>
Message-ID: <20151208001406.GS23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enric Balletbo Serra <eballetbo@gmail.com> [151204 06:40]:
> 2015-12-03 20:27 GMT+01:00 Tony Lindgren <tony@atomide.com>:
> > * Javier Martinez Canillas <javier@osg.samsung.com> [151203 10:29]:
> >
> >> Since is working for the boards with the libertas chip, I preferred
> >> to remove the DTS hack but left the boards with wlcore chip since
> >> you said the startup-delay-us is needed there (but probably we should
> >> add to the regulators in the boards that don't have it then).
> >
> > OK
> 
> I guess will be interesting cc'ing the ISEE people. Added Agusti and Pau.

Applying these both into omap-for-v4.5/dt thanks.

Tony
