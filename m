From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 23 Mar 2014 01:54:39 +0100
Subject: [PATCH 15/62] ARM: ixp4xx/omixp: always include linux/leds.h
In-Reply-To: <1395257399-359545-16-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Wed, 19 Mar 2014 20:29:12 +0100")
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-16-git-send-email-arnd@arndb.de>
Message-ID: <m3ppldhgz4.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The omixp board code unconditionally defines a gpio-led
> device, but for some reason includes the header file
> for this only if CONFIG_LEDS_CLASS is enabled, causing
> a build error otherwise.
>
> Removing the #ifdef fixes the build error with no downsides
> whatsoever.

Acked-by: Krzysztof Halasa <khc@pm.waw.pl>
-- 
Krzysztof Halasa
