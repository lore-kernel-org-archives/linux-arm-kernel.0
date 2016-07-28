From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 28 Jul 2016 20:17:57 +0200
Subject: [PATCH 1/4] ARM: dts: sun8i: Extend Orange Pi PC dt to also
 handle the PC Plus
In-Reply-To: <74d3b5eb-601a-cc1d-a44e-fea2895fd8b2@redhat.com>
References: <1468095718-18515-1-git-send-email-hdegoede@redhat.com>
 <20160713084505.GE4761@lukather>
 <bce2b340-a930-8771-4560-dc61bf5828d5@redhat.com>
 <20160725064033.GA7419@lukather>
 <74d3b5eb-601a-cc1d-a44e-fea2895fd8b2@redhat.com>
Message-ID: <20160728181757.GD6682@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Tue, Jul 26, 2016 at 11:07:23PM +0200, Hans de Goede wrote:
> >>>Nothing prevents you from including the orange pi pc dts, from the
> >>>orange pi plus dts.
> >>>
> >>>It prevents the duplication you were trying to avoid, and it doesn't
> >>>create all those spurious errors and devices.
> >>
> >>That would solve the copy paste problem on the kernel side, but that
> >>would still mean adding a new u-boot defconfig for this, which means that
> >>all the distro's which ship with prebuild u-boot binaries need to build
> >>for yet another board, something which I would like to avoid.
> >
> >Still, registering devices that are not present on the board is not an
> >option.
> 
> Ok, new version send.
> 
> What about the other 3 patches in this series ?

I guess the same comment applies for patch 2.

I'll look at the two others.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160728/24e766f1/attachment.sig>
