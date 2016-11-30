From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 14:56:32 +0100
Subject: [GIT PULL 4/4] DaVinci defconfig updates for v4.10 (part 2)
In-Reply-To: <20161120134038.14998-4-nsekhar@ti.com>
References: <20161120134038.14998-1-nsekhar@ti.com>
 <20161120134038.14998-4-nsekhar@ti.com>
Message-ID: <5631177.bAIffrK0pv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, November 20, 2016 7:10:38 PM CET Sekhar Nori wrote:
> The following changes since commit 6e9be8608771192851a3adf59f0ba9240e3f802c:
> 
>   ARM: davinci_all_defconfig: enable LED default-on trigger (2016-11-01 11:42:54 +0530)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git davinci-for-v4.10/defconfig-2
> 
> for you to fetch changes up to a652baa06413a4beacc09425883e518c5f1ed100:
> 
>   ARM: davinci_all_defconfig: add missing options for systemd (2016-11-15 15:44:52 +0530)
> 
> ----------------------------------------------------------------
> Enables newly introduced DDR controller and
> master priority setting drivers in kernel.
> 
> Also, update defconfig to boot latest systemd
> based filesystems on DA850.
> 

I pulled part 3 first, which contained this.

	Arnd
