From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jul 2012 11:16:26 +0000
Subject: [PATCH 1/1] Add Wondermedia Technologies (wmt) to
 docs/devicetree/vendor-bindings.txt
In-Reply-To: <76F764B079F92A4E843589C893D0A022C381059B@SERVER.prisktech.co.nz>
References: <76F764B079F92A4E843589C893D0A022C380F1D4@SERVER.prisktech.co.nz>
 <CABjd4Yyk6XR6RizgcpjCdi2N_+Z2EzTtezbkN9V7r4bAXXjhqA@mail.gmail.com>
 <76F764B079F92A4E843589C893D0A022C381059B@SERVER.prisktech.co.nz>
Message-ID: <201207191116.27273.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 July 2012, Tony Prisk wrote:
> Given that there have been no replies to this thread, and the restart patch has
> now been accepted using 'wmt' as the vendor namespace - would it be safe to
> assume we should formalize this in the vendor-bindings.txt?
> 
> I'd like to try and have basic device tree support added for the next merge
> window (or this one if it all goes well :) ), but it relies on the vendor binding being
> formalized.

What about devices that come from via though? Anything that first showed up
in vt8500 or earlier should probably get a prefix identifying VIA rather
than WonderMedia.

	Arnd
