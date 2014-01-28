From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jan 2014 13:01:54 +0000
Subject: [Patch v3 2/2] dmaengine: qcom_bam_dma: Add device tree binding
In-Reply-To: <4916428.f0GtxdkWKj@wuerfel>
References: <1390890471-14882-1-git-send-email-agross@codeaurora.org>
 <20140128111756.GE15937@n2100.arm.linux.org.uk>
 <20140128113242.GJ10628@intel.com> <4916428.f0GtxdkWKj@wuerfel>
Message-ID: <20140128130153.GI15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 01:05:10PM +0100, Arnd Bergmann wrote:
> Ok, thanks for clearing up my mistake. However, the argument remains:
> the direction doesn't need to be in the DT DMA descriptor since it
> gets set by software anyway.

Yes - for full-duplex, it's implied, since you have one DMA request
(and therefore virtual channel) for memory-to-device and another for
device-to-memory.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
