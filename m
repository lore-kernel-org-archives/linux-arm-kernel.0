From: carlo@endlessm.com (Carlo Caione)
Date: Wed, 22 Feb 2017 15:47:46 +0100
Subject: [PATCH 2/2] ARM64: dts: meson-gxl: Add support for HwaCom AmazeTV
In-Reply-To: <20170222144406.zycqtc77dygavh3q@rob-hp-laptop>
References: <20170212193247.22705-1-carlo@caione.org>
 <20170212193247.22705-3-carlo@caione.org>
 <20170222144406.zycqtc77dygavh3q@rob-hp-laptop>
Message-ID: <CAL9uMOGeoSe2SwK=5kmpt7kAgjkQta_CgkPqnc8F5W88_JzDhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2017 at 3:44 PM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Feb 12, 2017 at 08:32:47PM +0100, Carlo Caione wrote:

> I'm going to start asking people to use SPDX tags and you are the first. :)

Glad to be the first one :D

> SPDX-License-Identifier: GPL2.0+ OR MIT
>
> Note that is really MIT license and not X11 which has additional
> clauses.

ok

>> +
>> +/dts-v1/;
>> +
>> +#include "meson-gxl-s905x.dtsi"
>> +
>> +/ {
>> +     compatible = "hwacom,amazetv", "amlogic,s905x", "amlogic,meson-gxl";
>> +     model = "HWACOM AMAZETV (S905X)";
>
> Why yelling the model?

Because also the file that I used as template
(meson-gxl-nexbox-a95x.dts) was yelling it.
Capslock change in v2.

thanks,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
