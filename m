From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 2 Oct 2013 17:04:44 +0100
Subject: [PATCH v5 0/4] Target CPU=Host implementation for KVM ARM/ARM64
In-Reply-To: <1380531008-15901-1-git-send-email-anup.patel@linaro.org>
References: <1380531008-15901-1-git-send-email-anup.patel@linaro.org>
Message-ID: <20131002160444.GA49034@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 02:20:04PM +0530, Anup Patel wrote:
> It will be very useful for user space (QEMU/KVMTOOL) if it has a
> method of querying VCPU target type matching to underlying Host.
> We can use such querying mechanism and implement machine models
> in user space where VCPU target type is always same-as/similar-to
> underlying Host (i.e. Target CPU=Host).
> 
> This patch series implements KVM_ARM_PREFERRED_TARGET vm ioclt for
> querying VCPU target type matching underlying host. Using this new
> ioctl we can implement VCPU target CPU=Host in user space.
> 
> Also, it is not mandatory to call KVM_ARM_PREFERRED_TARGET vm ioctl
> and the old method of trying all possible target types using the
> KVM_ARM_VCPU_INIT ioctl to initialize VCPU works fine.
> 
Looks good to me, as soon as Marc acks this one, I'll merge it.

-Christoffer
