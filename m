From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 03 Sep 2013 17:53:13 +0400
Subject: [PATCH 1/4] ARM: shmobile: r8a7778: add Ether DT support
In-Reply-To: <2922765.My7X58lhxd@avalon>
References: <201309010311.05466.sergei.shtylyov@cogentembedded.com>
 <1738124.5rApJWhXUN@avalon> <1378135954.3321.5.camel@hornet>
 <2922765.My7X58lhxd@avalon>
Message-ID: <5225E9C9.2060906@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03-09-2013 16:11, Laurent Pinchart wrote:

>>> Documentation/devicetree/booting-without-of.txt mentions it, as well as a
>>> couple of other DT bindings document, but there's no clear documentation
>>> of what device_type should be for network device, and whether the property
>>> is mandatory or optional. Clarifying the documentation would be great.

>> It's documented in the ePAPR spec:

>> "The device_type property was used in IEEE 1275 to describe the device?s
>> FCode programming model. Because ePAPR does not have FCode, new use of
>> the property is deprecated, and it should be included only on cpu and
>> memory nodes for compatibility with IEEE 1275?derived device trees."

> Thank you for the clarification.

>> The bottom line is - don't use it, unless you've good good reasons?

> I'll let Sergei share his opinion on whether we've got good reasons :-)

    No, we don't, I'll remove the prop.

WBR, Sergei
