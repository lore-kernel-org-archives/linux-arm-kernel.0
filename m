From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 02 Sep 2013 16:32:34 +0100
Subject: [PATCH 1/4] ARM: shmobile: r8a7778: add Ether DT support
In-Reply-To: <1738124.5rApJWhXUN@avalon>
References: <201309010311.05466.sergei.shtylyov@cogentembedded.com>
 <1643070.uIkONXsrBj@avalon> <52249B16.8010409@cogentembedded.com>
 <1738124.5rApJWhXUN@avalon>
Message-ID: <1378135954.3321.5.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-09-02 at 15:18 +0100, Laurent Pinchart wrote:
> Documentation/devicetree/booting-without-of.txt mentions it, as well as a 
> couple of other DT bindings document, but there's no clear documentation of 
> what device_type should be for network device, and whether the property is 
> mandatory or optional. Clarifying the documentation would be great.

It's documented in the ePAPR spec:

"The device_type property was used in IEEE 1275 to describe the device?s
FCode programming model. Because ePAPR does not have FCode, new use of
the property is deprecated, and it should be included only on cpu and
memory nodes for compatibility with IEEE 1275?derived device trees."

The bottom line is - don't use it, unless you've good good reasons?

Pawe?
