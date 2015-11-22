From: mw@semihalf.com (Marcin Wojtas)
Date: Sun, 22 Nov 2015 22:55:03 +0100
Subject: [PATCH 02/13] net: mvneta: enable IP checksum with jumbo frames
 for Armada 38x on Port0
In-Reply-To: <5578695.0ahxvoVWDX@wuerfel>
References: <1448178839-3541-1-git-send-email-mw@semihalf.com>
 <4040597.3hXVb3XDMS@wuerfel>
 <CAPv3WKdOVf4kXHfrawgybggHggAEJ9wJh=8gyp_mEhWp2i=YFw@mail.gmail.com>
 <5578695.0ahxvoVWDX@wuerfel>
Message-ID: <CAPv3WKfW+V+dohsqcM7OLm3EBTqM9v-_96=Bkfu-BKoJV7Ss=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

>
> If the feature set depends on the port number, we should think about
> the way it gets handled again, as this is probably better not described
> as something that depends (just) on the SoC, but on the way it gets
> integrated. Maybe we can introduce an additional property for the
> checksums on jumbo frames and use that if present but fall back to
> identifying by compatible string otherwise.
>

I think adding a property, taking also compatible strings will be the
best solution.

Best regards,
Marcin
