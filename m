From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 4 Nov 2014 10:58:26 +0100
Subject: [PATCH v4 2/8] phy: miphy28lp: Add PHY header file for DT x
 Driver defines
In-Reply-To: <54589B78.3040104@ti.com>
References: <1413962067-25557-1-git-send-email-gabriel.fernandez@linaro.org>
 <1413962067-25557-3-git-send-email-gabriel.fernandez@linaro.org>
 <54589B78.3040104@ti.com>
Message-ID: <CAG374jDfd24odPXMGC1=1ckaeukk=8Pix1j_bspH5prNpJWhQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Sure, I'll update my patch set and sent to you soon as possible.

Best Regards

Gabriel

On 4 November 2014 10:25, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi Gabriel,
>
> On Wednesday 22 October 2014 12:44 PM, Gabriel FERNANDEZ wrote:
>> This provides the shared header file which will be reference from both
>> PHY driver and its associated Device Tree node(s).
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>> ---
>>  include/dt-bindings/phy/phy.h | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>  create mode 100644 include/dt-bindings/phy/phy.h
>>
>> diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
>> new file mode 100644
>> index 0000000..a142c69
>> --- /dev/null
>> +++ b/include/dt-bindings/phy/phy.h
>> @@ -0,0 +1,17 @@
>> +/*
>> + *
>> + * This header provides constants for the phy framework
>> + *
>> + * Copyright (C) 2014 STMicroelectronics
>> + * Author: Gabriel Fernandez <gabriel.fernandez@st.com>
>> + * License terms:  GNU General Public License (GPL), version 2
>> + */
>> +
>> +#ifndef _DT_BINDINGS_PHY
>> +#define _DT_BINDINGS_PHY
>> +
>> +#define PHY_TYPE_SATA                1
>> +#define PHY_TYPE_PCIE                2
>> +#define PHY_TYPE_USB         3
>
> Can we have a separate #define for USB2 and USB3? Looks like Gregory will need
> it for Armada 375 SoC.
>
> Thanks
> Kishon
