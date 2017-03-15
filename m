From: jnair@caviumnetworks.com (Jayachandran C)
Date: Wed, 15 Mar 2017 08:15:12 +0000
Subject: [PATCH v6 2/2] arm64: dts: move from ARCH_VULCAN to ARCH_THUNDER2
In-Reply-To: <8262c276-c39c-17b6-dcb6-d087d68d3df5@gmail.com>
References: <1489313015-4783-1-git-send-email-jnair@caviumnetworks.com>
 <1489495634-2920-1-git-send-email-jnair@caviumnetworks.com>
 <1489495634-2920-3-git-send-email-jnair@caviumnetworks.com>
 <8262c276-c39c-17b6-dcb6-d087d68d3df5@gmail.com>
Message-ID: <20170315081431.GA2415@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 11:16:47AM -0700, Florian Fainelli wrote:
> On 03/14/2017 05:47 AM, Jayachandran C wrote:
> > Move and update device tree files as part of transition from Broadcom
> > Vulcan to Cavium ThunderX2.
> > 
> > The changes are to:
> >  * rename dts/broadcom/vulcan.dtsi to cavium/thunder2-99xx.dtsi,
> >    update cpu cores to be "cavium,thunder2", and update SoC to be
> >    "cavium,thunderx2-cn9900"
> >  * move SoC dts/broadcom/vulcan-eval.dtsi to cavium/thunder2-99xx.dtsi
> >    and update board name string
> >  * Update dts/broadcom/Makefile not to build vulcan dtbs
> >  * Update dts/cavium/Makefile to build thunder2 dtbs
> > 
> > No changes to the dts contents except the updated "compatible" and
> > "model" properties.
> > 
> > Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> Can you also change the relevant entry in the MAINTAINERS file:
> 
> BROADCOM VULCAN ARM64 SOC
> M:      Jayachandran C. <c.jayachandran@gmail.com>
> M:      bcm-kernel-feedback-list at broadcom.com
> L:      linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
> S:      Maintained
> F:      arch/arm64/boot/dts/broadcom/vulcan*

I was planning to remove this entry in the later patchset that removes
ARCH_VULCAN. But, as you suggest, it makes more sense to do that now.

I will post an updated patchset with a new patch to update the entry.
 
> With that fixed:
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks,
JC.
