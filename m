From: greg@kroah.com (Greg KH)
Date: Wed, 28 Aug 2013 10:26:44 -0700
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
In-Reply-To: <20130828164506.3f8497c59e07b0ccaaa44aec@canb.auug.org.au>
References: <20130828164506.3f8497c59e07b0ccaaa44aec@canb.auug.org.au>
Message-ID: <20130828172644.GD5012@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 04:45:06PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got conflicts in
> arch/arm/boot/dts/am335x-bone.dts, arch/arm/boot/dts/am335x-evm.dts and
> arch/arm/boot/dts/am335x-evmsk.dts between commit c031a7d41934 ("usb:
> usb: dsps: update code according to the binding document") from the usb
> tree and commits 63f6b2550aa0 ("ARM: dts: AM33XX: don't redefine OCP bus
> and device nodes"), 781f17983015 ("usb: musb: am335x-evm: Do not remove
> the session bit HOST-only mode") and 2ae847a1b10f ("usb: musb: am335x:
> add second port to beagle bone") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Thanks, that looks good.

greg k-h
