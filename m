From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jan 2017 11:10:49 +0000
Subject: [PATCH v29 9/9] Documentation: dt: chosen properties for arm64
 kdump
In-Reply-To: <20161228043734.27535-1-takahiro.akashi@linaro.org>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043734.27535-1-takahiro.akashi@linaro.org>
Message-ID: <20170110111048.GA21598@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James, Akashi,

On Wed, Dec 28, 2016 at 01:37:34PM +0900, AKASHI Takahiro wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add documentation for
> 	linux,crashkernel-base and crashkernel-size,
> 	linux,usable-memory-range
> 	linux,elfcorehdr
> used by arm64 kdump to decribe the kdump reserved area, and
> the elfcorehdr's location within it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> [takahiro.akashi at linaro.org: added "linux,crashkernel-base" and "-size" ]
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: devicetree at vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 50 ++++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

I need an ack from Rob or Mark before I can merge this.

Will
