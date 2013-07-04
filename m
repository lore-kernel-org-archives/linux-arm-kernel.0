From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 04 Jul 2013 13:06:21 +0200
Subject: [PULL] Enable KVM on arm64
In-Reply-To: <51D55245.8080207@arm.com>
References: <51D55245.8080207@arm.com>
Message-ID: <51D5572D.40600@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 04/07/2013 12:45, Marc Zyngier ha scritto:
> Paolo, Gleb,
> 
> Following Linus' pull of the KVM/arm64 code, please pull the following
> patch that actually enables KVM on AArch64 platforms.
> 
> Thanks,
> 
> 	M.
> 
> The following changes since commit ddcf6600b133697adbafd96e080818bdc0dfd028:
> 
>   Merge tag 'hwmon-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging (2013-07-03 19:56:35 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/enable-kvm-for-3.11
> 
> for you to fetch changes up to e48bf1151165524a42a63611edcc961249ecc4b4:
> 
>   arm64: KVM: Kconfig integration (2013-07-04 11:34:43 +0100)

Please base this patch on commit fe489bf4 (Linus prefers not to have
pull requests base on "random HEAD of the day").  Also, please post the
patch. :)

Paolo
