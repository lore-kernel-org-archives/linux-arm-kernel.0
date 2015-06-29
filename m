From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 29 Jun 2015 17:04:21 +0200
Subject: [PATCH 1/3] ARM: at91/soc: add basic support for new sama5d2 SoC
In-Reply-To: <55913E3B.6060009@atmel.com>
References: <cover.1434632966.git.nicolas.ferre@atmel.com>
 <fe6d862c640a3708e80c0cc4c694ab5d9079060b.1434632966.git.nicolas.ferre@atmel.com>
 <20150618152105.GK27492@piout.net> <55913E3B.6060009@atmel.com>
Message-ID: <20150629150421.GB485@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/2015 at 14:46:51 +0200, Nicolas Ferre wrote :
> Le 18/06/2015 17:21, Alexandre Belloni a ?crit :
> > Hi,
> > 
> > On 18/06/2015 at 15:18:28 +0200, Nicolas Ferre wrote :
> >> diff --git a/Documentation/arm/Atmel/README b/Documentation/arm/Atmel/README
> >> index c53a19b4aab2..6650a8ffaa64 100644
> >> --- a/Documentation/arm/Atmel/README
> >> +++ b/Documentation/arm/Atmel/README
> >> @@ -90,6 +90,12 @@ the Atmel website: http://www.atmel.com.
> >>          + Datasheet
> >>            http://www.atmel.com/Images/Atmel-11238-32-bit-Cortex-A5-Microcontroller-SAMA5D4_Datasheet.pdf
> >>  
> >> +    * ARM Cortex-A5 + NEON based SoCs
> >> +      - sama5d2 family
> >> +        - sama5d27
> >> +        + Datasheet
> >> +          Coming soon
> > 
> > Shouldn't that go directly before or after the sama5d4 family ?
> 
> This is "after" sama5d4: I sorted this file according to SoC release
> date whereas I sorted the other entries in alpa-numerial order (sama5d2
> placed before sama5d3).
> 
> Is it what you answered?
> 

No, I meant doing something like:

    * ARM Cortex-A5 + NEON based SoCs
      - sama5d4 family
        - sama5d41
        - sama5d42
        - sama5d43
        - sama5d44 (device superset)
        + Datasheet
          http://www.atmel.com/Images/Atmel-11238-32-bit-Cortex-A5-Microcontroller-SAMA5D4_Datasheet.pdf
      - sama5d2 family
        - sama5d27
        + Datasheet
          Coming soon

Else, you end up with two "ARM Cortex-A5 + NEON based SoCs" sections.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
