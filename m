From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Tue, 06 Nov 2018 16:54:56 +0100
Subject: [PATCH v3 00/28] Allwinner H6 DE3 and HDMI support
In-Reply-To: <20181105094341.qedt7jvnxooiojki@flea>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
 <20181105094341.qedt7jvnxooiojki@flea>
Message-ID: <4663462.5OBby1Icb2@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ponedeljek, 05. november 2018 ob 10:43:41 CET je Maxime Ripard napisal(a):
> On Sun, Nov 04, 2018 at 07:26:37PM +0100, Jernej Skrabec wrote:
> > This series adds support for Display Engine 3.0 and HDMI 2.0a, which
> > can be found on H6 SoC.
> > 
> > Display Engine 3.0 in comparison to 2.0 mostly adds features needed for
> > displaying and processing 10-bit and AFBC formats, which are not yet
> > supported by this series.
> > 
> > H6 is also the first SoC which supports IOMMU, but support for it is
> > not yet added.
> > 
> > This series is based on linux-next at next-20181102.
> > 
> > I suggest all patches go through allwinner tree, except DRM patches,
> > which should go through drm-misc tree.
> 
> Applied all patches up to the 26. The two last one however should not
> use the clk bindings define you added in the first clk patches, since
> clk and dt patches are going through different tree.

Thanks!

Should I send remaining 2 patches as v4 or can be send separately?

Best regards,
Jernej
