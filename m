From: stefan@datenfreihafen.org (Stefan Schmidt)
Date: Sat, 11 Aug 2018 20:30:29 +0200
Subject: [RFC net-next 00/15] net: A socket API for LoRa
In-Reply-To: <20180810165711.59bf26f7@alans-desktop>
References: <20180701110804.32415-1-afaerber@suse.de>
 <CAC=mGzgUCopz2xTOA0R-WD8a1DOaOOUn=YpfdMiJ33y3hnh6kg@mail.gmail.com>
 <92ee4016-1da9-826b-3674-b2d604a64848@suse.de>
 <20180808213640.10a1d76f@alans-desktop>
 <a70e9715-beac-d9a8-145e-de00175e56fa@suse.de>
 <20180809125939.39ac2cc9@alans-desktop>
 <CAC=mGzjn4Kc-q9NFwX6NhU4V_thnzBP8SHtFQKyRbpSKR=yx3w@mail.gmail.com>
 <20180810165711.59bf26f7@alans-desktop>
Message-ID: <e703bd38-f45d-6dda-b0e3-404598fd4bab@datenfreihafen.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/10/2018 05:57 PM, Alan Cox wrote:
> 
> Long term yes I think Alexander is right the inevitable fate of all
> networks is to become a link layer in order to transmit IP frames 8)

There should be a niche for both at the same time. LoRaWAN is relevant
right now and we should aim for making it possible to run a native Linux
gateway for it.

As for IP for long range low power there is the static context header
compression draft to adapt IPv6 to the characteristics for some use
cases of such networks. Implementing it within the existing 6lwopan
subsystem should be possible.

https://tools.ietf.org/html/draft-ietf-lpwan-ipv6-static-context-hc-16

regards
Stefan Schmidt
