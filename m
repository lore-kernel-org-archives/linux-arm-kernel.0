From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 23 Apr 2013 21:25:11 +0800
Subject: [RFC PATCH v2 03/13] ARM: mach-at91: cpus/cpu node dts updates
In-Reply-To: <51768892.7060807@gmail.com>
References: <1366644455-16550-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366644455-16550-4-git-send-email-lorenzo.pieralisi@arm.com>
 <51768892.7060807@gmail.com>
Message-ID: <C0C2D01E-6F76-4606-9F63-70F3877C02BB@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Apr 23, 2013, at 9:11 PM, Rob Herring <robherring2@gmail.com> wrote:

> On 04/22/2013 10:27 AM, Lorenzo Pieralisi wrote:
>> This patch updates the in-kernel dts files according to the latest cpus
>> and cpu bindings updates for ARM.
>> 
>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> ---
>> arch/arm/boot/dts/at91sam9260.dtsi | 2 +-
>> arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
>> arch/arm/boot/dts/at91sam9g45.dtsi | 2 +-
>> arch/arm/boot/dts/at91sam9n12.dtsi | 2 +-
>> 4 files changed, 4 insertions(+), 4 deletions(-)
>> 
>> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
>> index cb7bcc5..2e9de85 100644
>> --- a/arch/arm/boot/dts/at91sam9260.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
>> @@ -33,7 +33,7 @@
>> 	};
>> 	cpus {
>> 		cpu at 0 {
>> -			compatible = "arm,arm926ejs";
>> +			compatible = "arm,arm926";
> 
> I don't understand why you are doing this. If this does not match the
> documentation, fix the documentation. We can't continue on changing dts
> files without reqard to breaking compatibility.

agreed and on AT91 it's a arm926ejs cpu
> 
> Rob
> 
>> 		};
>> 	};
>> 
>> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
>> index 271d4de..25c4725 100644
>> --- a/arch/arm/boot/dts/at91sam9263.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
>> @@ -30,7 +30,7 @@
>> 	};
>> 	cpus {
>> 		cpu at 0 {
>> -			compatible = "arm,arm926ejs";
>> +			compatible = "arm,arm926";
>> 		};
>> 	};
>> 
>> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
>> index 6b1d4ca..cf647d1 100644
>> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
>> @@ -36,7 +36,7 @@
>> 	};
>> 	cpus {
>> 		cpu at 0 {
>> -			compatible = "arm,arm926ejs";
>> +			compatible = "arm,arm926";
>> 		};
>> 	};
>> 
>> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
>> index 7750f98..d531ae3 100644
>> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
>> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
>> @@ -32,7 +32,7 @@
>> 	};
>> 	cpus {
>> 		cpu at 0 {
>> -			compatible = "arm,arm926ejs";
>> +			compatible = "arm,arm926";
>> 		};
>> 	};
>> 
>> 
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
