From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 10 Jun 2017 00:51:02 +0800
Subject: [linux-sunxi] Re: [PATCH v2 01/11] dt-bindings: update the
 binding for Allwinner H3 TVE support
In-Reply-To: <20170609164915.enap3epreg5vr2gy@flea.home>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-2-icenowy@aosc.io>
 <20170607084544.kgclybyxxttfk3ko@flea.lan>
 <092D4797-0034-4C39-A30A-92CFAB23AAF8@aosc.io>
 <20170609164915.enap3epreg5vr2gy@flea.home>
Message-ID: <53E8FC74-8AC0-461A-B875-812EE4A3267E@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?6?10? GMT+08:00 ??12:49:15, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Wed, Jun 07, 2017 at 04:48:50PM +0800, Icenowy Zheng wrote:
>> >> @@ -189,6 +211,8 @@ supported.
>> >>  Required properties:
>> >>    - compatible: value must be one of:
>> >>      * allwinner,sun8i-v3s-de2-mixer
>> >> +    * allwinner,sun8i-h3-de2-mixer0
>> >> +    * allwinner,sun8i-h3-de2-mixer1
>> >
>> >Again, please explain why we need to have different compatibles
>> >here. If it's only about the number of planes, this should be dealt
>> >with a property, not a compatible.
>> 
>> Only mixer0 has "VEP" and write-back support, at least on H3.
>
>What is that VEP? writeback support can also be expressed by a
>property.

I don't know what VEP is...

But we are really facing different cores, like sun50i-a64-mmc
and sun50i-a64-emmc.

>
>Maxime
