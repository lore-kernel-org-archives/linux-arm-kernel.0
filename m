From: csd@broadcom.com (Christian Daudt)
Date: Mon, 19 Nov 2012 09:50:09 -0800
Subject: [PATCH V5] Add support for generic BCM SoC chipsets
In-Reply-To: <50AA6F3B.4010801@wwwdotorg.org>
References: <1353196298-19016-1-git-send-email-csd@broadcom.com>
 <50AA6F3B.4010801@wwwdotorg.org>
Message-ID: <50AA7151.4080604@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-11-19 09:41 AM, Stephen Warren wrote:
> On 11/17/2012 04:51 PM, Christian Daudt wrote:
>> In order to start upstreaming Broadcom SoC support, create
>> a starting hierarchy, arch and dts files.
>> The first support SoC family that is planned is the
>> BCM281XX (BCM11130/11140/11351/28145/28155) family of dual A9 mobile
>> SoC cores.
>> This code is just the skeleton code for get the machine upstreamed. It
>> has been made MULTIPLATFORM compatible.
>> diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
>> +	uart at 3e000000 {
>> +		compatible = "bcm,bcm11351-sw-apb-uart", "snps,dw-apb-uart";
> s/-sw-/-dw-/ in the first compatible value?
>
> Aside from that,
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
done.

  thanks,
    csd
