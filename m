From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 30 Nov 2016 08:29:11 +0000
Subject: [PATCH v9 07/11] arm/arm64: vgic: Implement
 KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO ioctl
In-Reply-To: <20161130082411.GA6647@cbox>
References: <1479906118-15832-1-git-send-email-vijay.kilari@gmail.com>
 <1479906118-15832-8-git-send-email-vijay.kilari@gmail.com>
 <20161128195028.GH18170@cbox>
 <CALicx6uW5RmjsPPBKB5wLW4TzNmcdc9ZADqp=M2ZJe9Cd+keZg@mail.gmail.com>
 <20161129210901.GC15346@cbox>
 <CAFEAcA_1i7-ti_H_RZrTbCW2DmFPvYudKn_WFs=_XRoyKKsnbQ@mail.gmail.com>
 <20161130082411.GA6647@cbox>
Message-ID: <CAFEAcA-z=+K2ceRhLFMt7VXWD=RQyDKzS68SsO_pG3p=578wTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 November 2016 at 08:24, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> (Peter, I thought you once argued that it was important for user space
> to be able to save/restore the state without any ordering requirements,
> but I may have misunderstood.  It is still the option to add something
> like the above to the docs but also do our best to allow any ordering of
> level/config, but it becomes slightly more invasive.)

Hmm; perhaps I should think about this a bit more.

-- PMM
