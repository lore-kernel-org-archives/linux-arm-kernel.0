From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 30 Apr 2016 18:19:13 +0200
Subject: [GIT PULL] ARM: mvebu: defconfig for v4.7 (#2)
In-Reply-To: <87pot8sct4.fsf@free-electrons.com>
References: <87pot8sct4.fsf@free-electrons.com>
Message-ID: <20160430181913.3ceee35b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 29 Apr 2016 16:35:19 +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the second pull request for defconfig for mvebu for v4.7.
> 
> Gregory
> 
> The following changes since commit 23d2af622de748bf57d31a4125d06d183c29e908:
> 
>   ARM: mvebu_v5_defconfig: Switching to the new Marvell's cryptographic engine driver (2016-04-14 18:57:19 +0200)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-defconfig-4.7-2
> 
> for you to fetch changes up to acef3efe096d8de9f115f0d9e9c681147887bcac:
> 
>   arm64: marvell: enable AP806 and CP110 syscon driver (2016-04-26 15:20:51 +0200)
> 
> ----------------------------------------------------------------
> mvebu defconfig for 4.7 (part 2)
> 
> - enable AP806 and CP110 syscon driver in arm64 defconfig
> 
> ----------------------------------------------------------------
> Thomas Petazzoni (1):
>       arm64: marvell: enable AP806 and CP110 syscon driver

I am not sure how important that is, but this patch is in your
defconfig branch, but it's not defconfig related, and the same patch is
already in your mvebu-arm64-4.7-1 branch.

However, you indeed forgot my arm64 defconfig patch, so I believe there
might have been a mistake on your side here, unless I missed something
of course!

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
