From: stigge@antcom.de (Roland Stigge)
Date: Thu, 06 Sep 2012 11:32:03 +0200
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
In-Reply-To: <20120906154240.12f7e0c01686559dd43744fa@canb.auug.org.au>
References: <20120906154240.12f7e0c01686559dd43744fa@canb.auug.org.au>
Message-ID: <50486D93.4090009@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/2012 07:42 AM, Stephen Rothwell wrote:
> Today's linux-next merge of the arm-soc tree got a conflict in 
> drivers/usb/host/Kconfig between commit 952230d774bb ("usb: ohci:
> Fix Kconfig dependency on USB_ISP1301") from the usb tree and
> commit d684f05f2d55 ("ARM: mach-pnx4008: Remove architecture") from
> the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no
> action required).

Thanks - this little conflict was expected when merging pnx4008
removal and the isp1301 deoendency fix.

And the fixup is correct.

Roland
