From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 31 Jul 2015 14:46:18 +0900
Subject: [PATCH v2] dtb: Create a common home for cross-architecture dtsi
 files.
In-Reply-To: <CAK7LNAS_P65k3T_J_vXZ9dxBB-uVbrTW-qFE_fJEOSLcOW4JsA@mail.gmail.com>
References: <1437993343-9542-1-git-send-email-ian.campbell@citrix.com>
 <CAK7LNAQKswPzeFYdSVq3JDk2qawZ8e5ogBFMWdor-CibMovU3g@mail.gmail.com>
 <1438176174.11600.198.camel@citrix.com>
 <CAL_JsqL7KRcSv5jSneWYj1PJOYbvMQ8HOAGK+w-+MDBMpMatow@mail.gmail.com>
 <CAK7LNAS_P65k3T_J_vXZ9dxBB-uVbrTW-qFE_fJEOSLcOW4JsA@mail.gmail.com>
Message-ID: <CAK7LNAQ4hT133v0iH7z6JxfaBDjrGgaX2M9pA9H=sPxsmorDNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

2015-07-30 10:30 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Hi,
>
>
> 2015-07-30 0:23 GMT+09:00 Rob Herring <robherring2@gmail.com>:
>> On Wed, Jul 29, 2015 at 8:22 AM, Ian Campbell <ian.campbell@citrix.com> wrote:
>>> On Wed, 2015-07-29 at 20:07 +0900, Masahiro Yamada wrote:
>>>> Hi Ian,
>>>>
>>>>
>>>> 2015-07-27 19:35 GMT+09:00 Ian Campbell <ian.campbell@citrix.com>:
>>>> > Commit 9ccd608070b6 "arm64: dts: add device tree for ARM SMM-A53x2 on
>>>> > LogicTile Express 20MG" added a new dts file to arch/arm64 which
>>>> > included "../../../../arm/boot/dts/vexpress-v2m-rs1.dtsi", i.e. a
>>>> > .dtsi supplied by arch/arm.



BTW, is there any chance to merge arch/arm64 and arch/arm in the future?

For example, U-boot supports ARM64/32 in a single arch directory, arch/arm/.


I guess, the cross-arch home directory for DTSI would be only used to
share device trees between arm64 and arm32.





-- 
Best Regards
Masahiro Yamada
