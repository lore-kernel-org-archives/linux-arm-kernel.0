From: chris@techworks.ie (Christian Gagneraud)
Date: Sun, 15 May 2011 14:56:54 +0100
Subject: AT91: SPI: On implementing peripheral chip select decoding
Message-ID: <4DCFDBA6.6050007@techworks.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,

The AT91SAM9G20 SPI controller (and possibly other SAM9 or other SoC) 
has the ability to work with CS decoding, thus allowing up to 15 
peripherals with only 4 CS lines (CS[0:3]=0xF meaning no peripheral 
selected).
I would like to know if anyone has experimented with this feature, or if 
anyone has advices/ideas on how to add support for this feature in the 
linux kernel.

Before starting to work on this, I would like to know if this feature is 
common on other platforms or if it's AT91 specific.
In the former case, it might be wise to include it in the SPI subsystem, 
and in the latter case keep it inside AT91 code.

Chris
