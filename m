From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 26 Jul 2014 22:13:39 +0200
Subject: [PATCH] ARM: at91/dt: sam9x5: fix ADC compatible string
In-Reply-To: <53D40A60.2060100@cogentembedded.com>
References: <1406038067-14697-1-git-send-email-alexandre.belloni@free-electrons.com>
 <53D40A60.2060100@cogentembedded.com>
Message-ID: <20140726201338.GO9532@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27/07/2014 at 00:06:56 +0400, Sergei Shtylyov wrote :
> >diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> >index 2c0d6ea3ab41..5d7cf394f537 100644
> >--- a/arch/arm/boot/dts/at91sam9x5.dtsi
> >+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> >@@ -964,7 +964,7 @@
> >  			adc0: adc at f804c000 {
> >  				#address-cells = <1>;
> >  				#size-cells = <0>;
> >-				compatible = "atmel,at91sam9260-adc";
> >+				compatible = "atmel,at91sam9x5-adc";
> 
>    Actually, wildcards are not allowed in the "compatible" prop.
> 

This is not really a wildcard, the sam9x5 family of SoC is supported
through only one dtsi, at91sam9x5.dtsi and this name is used for all the
compatible strings of the IPs that appeared with that family.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
