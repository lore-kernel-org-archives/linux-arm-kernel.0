From: kishon@ti.com (ABRAHAM, KISHON VIJAY)
Date: Wed, 18 Jul 2012 11:13:00 +0530
Subject: [PATCH 2/2] arm/dts: omap4: Add ocp2scp data
In-Reply-To: <50055C38.3000309@mvista.com>
References: <1342448023-14438-1-git-send-email-kishon@ti.com>
 <1342448023-14438-3-git-send-email-kishon@ti.com>
 <50055C38.3000309@mvista.com>
Message-ID: <CAAe_U6KGPnTefBVzYises6-+o40MZTr8j+zLRB504TDOfmsf9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 17, 2012 at 6:06 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Hello.
>
>
> On 16-07-2012 18:13, Kishon Vijay Abraham I wrote:
>
>> Add ocp2scp data node in omap4 device tree file.
>
>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   arch/arm/boot/dts/omap4.dtsi |    8 ++++++++
>>   1 files changed, 8 insertions(+), 0 deletions(-)
>
>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 359c497..bda5df3 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -272,5 +272,13 @@
>>                         ti,hwmods = "mmc5";
>>                         ti,needs-special-reset;
>>                 };
>> +
>> +               ocp2scp at 4a0ad000  {
>
>
>    "reg" property is absent, so why do you give the node name an address
> postfix?
When I was initially developing, I had "reg" property populated. Those
info is now obtained from *ti,hwmods*. I'll resend the patch removing
it.

Thanks
Kishon
