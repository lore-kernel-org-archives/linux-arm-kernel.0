From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 8 Nov 2013 12:06:26 -0600
Subject: [PATCH v3 7/9] ARM: add Armada 1500 and Sony NSZ-GS7 device tree
 files
In-Reply-To: <20131108165721.GA10335@titan.lakedaemon.net>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-8-git-send-email-sebastian.hesselbarth@gmail.com>
 <0AF697FD-60AA-4B8B-A35F-3DF2FFBCF7AF@codeaurora.org>
 <20131108165721.GA10335@titan.lakedaemon.net>
Message-ID: <8DC09031-553C-4FD5-8F05-F93D6FE40F3A@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Nov 8, 2013, at 10:57 AM, Jason Cooper wrote:

> On Fri, Nov 08, 2013 at 10:13:19AM -0600, Kumar Gala wrote:
>> On Nov 5, 2013, at 8:28 AM, Sebastian Hesselbarth wrote:
> ...
>>> .../devicetree/bindings/arm/marvell,berlin.txt     |   24 +++
>>> arch/arm/boot/dts/Makefile                         |    2 +
>>> arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts         |   29 +++
>>> arch/arm/boot/dts/berlin2.dtsi                     |  227 ++++++++++++++++++++
>>> 4 files changed, 282 insertions(+)
>>> create mode 100644 Documentation/devicetree/bindings/arm/marvell,berlin.txt
>>> create mode 100644 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
>>> create mode 100644 arch/arm/boot/dts/berlin2.dtsi
>> 
>> Haven't we been trying to go away from non-prefixed dts/dtsi?
> 
> hmmm, this is the first I've heard of that.  Although, your proposal
> (in another thread) makes more sense now.  :)
> 
>> So should these be something like marvell-berlin2-...
> 
> I don't recall this being brought up at the summit, nor in Grant's
> report.  I do need to give it a more careful read this weekend, though.
> Perhaps I missed something.

This was based on review comments Olof gave when we pushed some .dts files for MSM/APQ Qualcomm Technologies soc/boards.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
