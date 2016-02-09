From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 9 Feb 2016 19:49:20 +0100
Subject: [PATCH v2 00/28] ARM: KVM: Rewrite the world switch in C (mostly)
In-Reply-To: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160209184920.GB5171@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 11:00:17AM +0000, Marc Zyngier wrote:
> Now that the arm64 rewrite is in mainline, I've taken a stab at fixing
> the 32bit code the same way. This is fairly straightforward (once
> you've been through it once...), with a few patches that adapt the
> code to be similar to the 64bit version.
> 
> Note that the timer and GIC code should be made common between the two
> architectures, as this is litterally the exact same code (I've posted
> some proof of concept for that a while ago, see
> http://www.spinics.net/lists/kvm/msg126775.html).
> 
> This has been tested on a Dual A7, and the code is pushed on a branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm/wsinc
> 

This looks good overall.

I tested it briefly on TC2 and it seems generally happy.

-Christoffer
