From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Sun, 28 Sep 2014 16:58:50 -0700 (PDT)
Subject: [periperi] How to set default GPIO pin ?
In-Reply-To: <2033766.6tR9OHe7ZC@avalon>
References: <8738cc0vx9.wl%kuninori.morimoto.gx@gmail.com>
 <2862746.g5u9pdpKDi@avalon>
 <CACRpkdb1jF-ro3XcFHFC+Lhgi+0dEHzQYVSSLV6AWnAxiwNLdw@mail.gmail.com>
 <2033766.6tR9OHe7ZC@avalon>
Message-ID: <8738bb9u1a.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Laurent, Linus

> > I have suggested adding GPIO hogs, so that a GPIO node can specify
> > that some GPIO's specified on the local ship be hogged high or
> > low at probe. Generic DT bindings and generic code in gpiolib.c.
> > 
> > gpios-hog-high = <....>;
> > gpios-hog-low = <....>;
> 
> How about just a gpios-hog property, with a list of gpio specifiers + flags ? 
> That's bikeshedding I suppose.
> 
> Morimoto-san, would you like to implement that ? :-)

Thank you for your help
OK, I try to implement this method (when I have time :)
Thank you

Best regards
---
Kuninori Morimoto
