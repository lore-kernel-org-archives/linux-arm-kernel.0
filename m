From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 03 Sep 2013 14:11:17 +0200
Subject: [PATCH 1/4] ARM: shmobile: r8a7778: add Ether DT support
In-Reply-To: <1378135954.3321.5.camel@hornet>
References: <201309010311.05466.sergei.shtylyov@cogentembedded.com>
 <1738124.5rApJWhXUN@avalon> <1378135954.3321.5.camel@hornet>
Message-ID: <2922765.My7X58lhxd@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawe?,

On Monday 02 September 2013 16:32:34 Pawel Moll wrote:
> On Mon, 2013-09-02 at 15:18 +0100, Laurent Pinchart wrote:
> > Documentation/devicetree/booting-without-of.txt mentions it, as well as a
> > couple of other DT bindings document, but there's no clear documentation
> > of what device_type should be for network device, and whether the property
> > is mandatory or optional. Clarifying the documentation would be great.
> 
> It's documented in the ePAPR spec:
> 
> "The device_type property was used in IEEE 1275 to describe the device?s
> FCode programming model. Because ePAPR does not have FCode, new use of
> the property is deprecated, and it should be included only on cpu and
> memory nodes for compatibility with IEEE 1275?derived device trees."

Thank you for the clarification.

> The bottom line is - don't use it, unless you've good good reasons?

I'll let Sergei share his opinion on whether we've got good reasons :-)

-- 
Regards,

Laurent Pinchart
