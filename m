From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 8 Feb 2016 18:04:19 +0000
Subject: [RESEND2 PATCH 0/3] Fix kernel panic in dma-coherent
In-Reply-To: <56B8D77D.3050305@arm.com>
References: <cover.1454950917.git.brian.starkey@arm.com>
 <20160208175054.GD15443@leverpostej> <56B8D77D.3050305@arm.com>
Message-ID: <20160208180418.GE15443@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 05:59:25PM +0000, Robin Murphy wrote:
> Hi Mark,
> 
> On 08/02/16 17:50, Mark Rutland wrote:
> >On Mon, Feb 08, 2016 at 05:30:49PM +0000, Brian Starkey wrote:
> >>Hi,
> >>
> >>I'm resending these again to try and garner some interest. Without
> >>this series, dma-coherent cannot be used on arm64 platforms.
> >
> >I think you need to characterize that a bit better. I see plenty of
> >instances of 'dma-coherent' in dts files, assuming you mean the DT
> >dma-coehrent property.
> >
> >If not, feel free to stop reading now.
> 
> Terminology overload: the dma-coherent DT property is about devices
> having cache-coherent access to system memory within the linear map.
> The dma-coherent thing here is pretty much the precise opposite of
> that - namely creating CPU mappings for memory which belongs to the
> device itself and may be behind an I/O bus (e.g. a framebuffer on a
> video card).

Phew.

Sorry for the noise, and thanks for setting me straight!

Mark.
