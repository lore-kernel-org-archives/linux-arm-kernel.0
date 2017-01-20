From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 20 Jan 2017 14:51:42 +0100
Subject: [PATCH v10 0/8] arm/arm64: vgic: Implement API for vGICv3 live
 migration
In-Reply-To: <588020D2.4020108@huawei.com>
References: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
 <588020D2.4020108@huawei.com>
Message-ID: <20170120135142.GA13531@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On Thu, Jan 19, 2017 at 10:13:38AM +0800, Shannon Zhao wrote:
> Hi Vijaya,
> 
> On 2016/12/1 15:09, vijay.kilari at gmail.com wrote:
> > From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> > 
> > This patchset adds API for saving and restoring
> > of VGICv3 registers to support live migration with new vgic feature.
> > This API definition is as per version of VGICv3 specification
> > Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> > 
> > The patch 3 & 4 are picked from the Pavel's previous implementation.
> > http://www.spinics.net/lists/kvm/msg122040.html
> > 
> > NOTE: Only compilation tested for AArch32. No hardware to test.
> > 
> Where can I fetch the latest corresponding QEMU patches? I didn't find
> them in qemu-devel/qemu-arm mail list.
> 

Vijaya must have gotten something wrong in sending to the lists, because
I couldn't find them in the archive either, and Eric also couldn't find
them.  But I was cc'ed, so I've bounced them your way.

-Christoffer
