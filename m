From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jan 2014 14:13:13 +0000
Subject: [PATCH RFC 03/26] dmaengine: omap-dma: program hardware directly
In-Reply-To: <52DFBF89.3020102@ti.com>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk>
 <E1Vyjtf-0005E5-Vw@rmk-PC.arm.linux.org.uk> <52DFBF89.3020102@ti.com>
Message-ID: <20140122141313.GP27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 06:24:33PM +0530, Sricharan R wrote:
> EI and FI are always set to zero. So interleaved transfers support
> have to enabled in omap-dma, as it was supported by the
> legacy driver. It was not enabled because of no users of the feature,
>  right  ?

None of the users of the legacy driver used this feature.  Moreover,
dmaengine doesn't have the interfaces to support this specialised
feature at present.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
