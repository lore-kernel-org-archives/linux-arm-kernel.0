From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 22 Oct 2014 10:46:27 +0200
Subject: [linux-sunxi] Re: [PATCH v2 4/4] ARM: dts: sun7i: Add lradc node
In-Reply-To: <20141022083802.GE7893@lukather>
References: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
 <1413879890-7254-5-git-send-email-hdegoede@redhat.com>
 <20141022083802.GE7893@lukather>
Message-ID: <54476EE3.6060401@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 10/22/2014 10:38 AM, Maxime Ripard wrote:
> Hi Hans,
> 
> On Tue, Oct 21, 2014 at 10:24:50AM +0200, Hans de Goede wrote:
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 48 +++++++++++++++++++++++++
>>  arch/arm/boot/dts/sun7i-a20.dtsi                |  7 ++++
>>  2 files changed, 55 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>> index 9d669cdf..85e7194 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
>> @@ -14,6 +14,7 @@
>>  /dts-v1/;
>>  /include/ "sun7i-a20.dtsi"
>>  /include/ "sunxi-common-regulators.dtsi"
>> +#include <dt-bindings/input/input.h>
> 
> I'm just wondering... Weren't we supposed to switch all includes to
> the preprocessor syntax in such a case?

I've just checked other in tree users of dt-bindings/input/input.h and you
seem to be right, I will fix this for the next version.

Regards,

Hans
