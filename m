From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 17 Aug 2017 08:02:36 -0700
Subject: [PATCH] ARM: dts: imx6qdl-nitrogen6_som2: fix PCIe reset
In-Reply-To: <20170817135010.3042-1-gary.bisson@boundarydevices.com>
References: <20170817135010.3042-1-gary.bisson@boundarydevices.com>
Message-ID: <20170817150236.GA8358@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 03:50:10PM +0200, Gary Bisson wrote:
> Previous value was a bad copy of nitrogen6_max device tree.
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
