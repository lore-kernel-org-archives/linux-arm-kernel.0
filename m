From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu, 28 Nov 2013 14:50:08 +0100
Subject: ACPI
In-Reply-To: <CAHCPf3ubLbeEGN-M-GW=ZByH48s=WxMTuWFhEs0mBhuXjUOAMQ@mail.gmail.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
 <20131127141634.A45F3C404EC@trevor.secretlab.ca>
 <CAHCPf3ubLbeEGN-M-GW=ZByH48s=WxMTuWFhEs0mBhuXjUOAMQ@mail.gmail.com>
Message-ID: <20131128135008.GS24997@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 27, 2013 at 04:17:41PM -0600, Matt Sealey wrote:
> UEFI hands control to an entry point of a PE/COFF executable (the only
> thing it's required to know how to load) passing the pointer to the
> System Table as it's second argument, location defined by the UEFI
> specification. This is completely subverted in LinuxLoader and the EFI
> patches you mentioned, which I have seen before and I honestly don't
> understand why it was done this way - except to assume that rampant
> paranoia about something new and different took hold, and some
> internal discussion ended up with "the mainline guys will never accept
> this.... how do we work around that?"

The LinuxLoader is a legacy thing which needs to go away.
Proper UEFI support in the kernel is one way of making that possible.

Don't really understand yor comments about the arm kernel UEFI support,
but there seems to be some misunderstanding here, so I don't think going
over your email and tickbox-refuting them one by one will be of much
use to anyone.

I will be posting an updated set of the arm patches today, to go with
the updated UEFI stub patches submitted by Roy last night. I will be
happy to discuss the topics mentioned as part of this message as part
of the review of those, if you still consider them an issue.

But let's be clear - my intent is to get UEFI first-class citizen
status in the arm kernel.

/
    Leif
