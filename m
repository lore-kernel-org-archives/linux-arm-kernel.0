From: daniel@caiaq.de (Daniel Mack)
Date: Sun, 21 Mar 2010 13:47:39 +0100
Subject: PXA3xx internal SRAM
Message-ID: <20100321124739.GG30801@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa3xx series features a comparatively big and fast internal SRAM of
256KB which is currently unused by the Linux kernel except for a 4-byte
return vector from suspend.

I wonder what this could be used for. Is there any kind of cache that
would be worth putting there to speed up things for example?
And could the uncompressor probably benfit from that?

Daniel
