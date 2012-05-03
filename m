From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 03 May 2012 15:24:36 +0200
Subject: Development tree for =?UTF-8?Q?Cortex-A=31=35=3F?=
In-Reply-To: <1336046199.46241.YahooMailNeo@web132501.mail.ird.yahoo.com>
References: <1336046199.46241.YahooMailNeo@web132501.mail.ird.yahoo.com>
Message-ID: <bc6e93f98278125c354282f23751b1aa@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 May 2012 12:56:39 +0100 (BST), Jemma Jones
<jemmajones81@yahoo.co.uk> wrote:

Hi Jemma,

> Hi, I'm looking for the latest KVM-enabled developer version of the
Linux
> kernel for ARM on the Versatile Express board with the Cortex-A15 CPU.?

It really depends on what you call "developer version". As far as I know,
there is nothing but dev trees around ;-).
 
> I have pulled from these two trees
> 
>
http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-arm-arch.git;a=summary
>
http://git.kernel.org/?p=linux/kernel/git/maz/arm-platforms.git;a=summary
> 
> But it seems the 2nd one is more up-to-date with KVM enablement while it
> doesn't have any support for the A15 VE board? And the 1st one doesn't
> support KVM on ARM with the ARMv7 virtualization extensions?

First, my tree (the second one) does support the A15. Otherwise I'd have a
hard time testing my own code... Which branch are you looking at? Please
note that the KVM branches in this tree are under heavy development, and
are only suitable if you don't mind frequent rebases and regular breakage
due to bleeding edge code.

If you want something more stable, you probably want to have a look at
Christoffer Dall's tree:
https://github.com/virtualopensystems/linux-kvm-arm

You also may need to join the KVM-ARM mailing list (named android-virt for
historical reasons):
https://lists.cs.columbia.edu/cucslists/listinfo/android-virt

One last thing though: all our developments are done on the Cortex-A15
FastModel. In your email, you keep mentioning the VE board. For the time
being, we have nothing running on the real hardware, only on the model.

Good luck! ;-)

        M.
-- 
Fast, cheap, reliable. Pick two.
