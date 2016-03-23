From: carlo@caione.org (Carlo Caione)
Date: Wed, 23 Mar 2016 09:18:47 +0100
Subject: [PATCH] ARM64: dts: amlogic: add basic support for P200 and
 odroid-C2
In-Reply-To: <56F1E847.3060004@suse.de>
References: <1458692498-9210-1-git-send-email-khilman@baylibre.com>
 <56F1E847.3060004@suse.de>
Message-ID: <CAOQ7t2a+7Z_17J7SbgP1uJqMSAQixz721voC-N0G6O7-M-0JLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 1:50 AM, Andreas F?rber <afaerber@suse.de> wrote:

[...]

>> +
>> +/dts-v1/;
>> +
>> +#include "meson-gxbb.dtsi"
>> +
>> +/ {
>> +     compatible = "amlogic,meson-gxbb-odroidc2", "amlogic,meson-gxbb";
>
> This should be "hardkernel,odroid-c2", "amlogic,meson-gxbb".
>
> And the compatible string needs to be documented in
> Documentation/devicetree/bindings/arm/amlogic.txt. Officially that's
> requested to be a separate patch, so maybe split P200 and C2 while at it
> to encourage people providing a Tested-by for this more common one?

Yes, please.

[...]

>> +
>> +/dts-v1/;
>> +
>> +#include "meson-gxbb.dtsi"
>> +
>> +/ {
>> +     compatible = "amlogic,meson-gxbb-p200", "amlogic,meson-gxbb";
>
> How unique is P200? I wonder whether we could simplify this to
> "amlogic,p200", "amlogic,meson-gxbb". I.e., is there or might there be a
> P200 board for a different SoC?

I think that we can safely just use "amlogic,p200" here.

Thank you!

-- 
Carlo Caione
