From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Nov 2015 12:45:40 +0100
Subject: [PATCH v2] ARM: sunxi: Re-enable SID driver in multi_v7_defconfig
In-Reply-To: <564E62DF.5030407@samsung.com>
References: <1447724947-4851-1-git-send-email-public_timo.s@silentcreek.de>
 <1447968823-2159-1-git-send-email-public_timo.s@silentcreek.de>
 <564E62DF.5030407@samsung.com>
Message-ID: <20151120114540.GA32142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 20, 2015 at 09:01:35AM +0900, Krzysztof Kozlowski wrote:
> On 20.11.2015 06:33, Timo Sigurdsson wrote:
> > Commit 3d0b16a66c8a ("nvmem: sunxi: Move the SID driver to the nvmem
> > framework") moved the the sunxi SID driver to a new framework, but left
> > multi_v7_defconfig with the deprecated config symbol EEPROM_SUNXI_SID
> > instead of the new symbol NVMEM_SUNXI_SID. Hence, re-enable the driver
> > in multi_v7_defconfig.
> > 
> > Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
> > ---
> > Changes in v2:
> > - Move the extra cleanup work for multi_v7_defconfig to a separate
> >   patch (to be submitted at a later point to avoid conflicts with
> >   another patch waiting to be merged)
> > ---
> >  arch/arm/configs/multi_v7_defconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> 
> Fully satisfies my v1's comments:
> 
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151120/b89906b8/attachment.sig>
