From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 27 Jan 2017 11:27:21 +0100
Subject: [PATCH v11 0/8] arm/arm64: vgic: Implement API for vGICv3 live
 migration
In-Reply-To: <9fea1713-7087-7052-5ca6-d9257a6f973a@arm.com>
References: <1485440453-10597-1-git-send-email-vijay.kilari@gmail.com>
 <20170126202640.GD15850@cbox>
 <9fea1713-7087-7052-5ca6-d9257a6f973a@arm.com>
Message-ID: <20170127102721.GA10506@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 09:45:06AM +0000, Marc Zyngier wrote:
> On 26/01/17 20:26, Christoffer Dall wrote:
> > Hi Vijaya,
> > 
> > On Thu, Jan 26, 2017 at 07:50:45PM +0530, vijay.kilari at gmail.com wrote:
> >> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> >>
> >> This patchset adds API for saving and restoring
> >> of VGICv3 registers to support live migration with new vgic feature.
> >> This API definition is as per version of VGICv3 specification
> >> Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> >>
> >> The patch 3 & 4 are picked from the Pavel's previous implementation.
> >> http://www.spinics.net/lists/kvm/msg122040.html
> >>
> >> NOTE: Only compilation tested for AArch32. No hardware available to test.
> > 
> > Thanks for the respin.  I've given this a once-over and tested on GICv2
> > against migrations and on GICv3 for this functionality, and it looks

haha, just noticed this.  That's against *regressions* obviously.


> > good.
> > 
> > It would be good to see a soon respin of the QEMU series as well.
> > 
> > Marc, unless others have objections to this series, I think we can queue
> > this series.
> 
> Yup, I'll queue it on top. Thanks everyone for sticking with this series.
> 

Thanks,
-Christoffer
