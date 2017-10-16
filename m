From: icenowy@aosc.io (icenowy at aosc.io)
Date: Mon, 16 Oct 2017 17:41:10 +0800
Subject: [PATCH 1/2] dt-bindings: add binding for A64 DE2 CCU with SRAM
 section
In-Reply-To: <20171016091136.b4rnckh2tfi26shx@flea.lan>
References: <20171014122925.13220-1-icenowy@aosc.io>
 <20171016091136.b4rnckh2tfi26shx@flea.lan>
Message-ID: <d62ac8b8ff9073b886ceaa9ce54e6903@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-10-16 17:11?Maxime Ripard ???
> On Sat, Oct 14, 2017 at 08:29:24PM +0800, Icenowy Zheng wrote:
>> A64's Display Engine 2.0 needs a section of SRAM (SRAM C) to be 
>> claimed.
> 
> Why?

Allwinner didn't document this, but if the SRAM is not claimed, the
DE2 MMIO zone is totally not accessible.

It seems that Allwinner uses the SRAM C in the DE2 internally.

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
