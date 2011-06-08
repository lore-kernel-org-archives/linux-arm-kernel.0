From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Jun 2011 17:00:48 +0200
Subject: [PATCH v4 5/5] ARM: mmp2: update mmp2_defconfig to support mmc
In-Reply-To: <723849F6A4B5A3408299DF1FFE37CA776C09CFC25F@BGMAIL02.nvidia.com>
References: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
	<1307526121-12059-6-git-send-email-zhangfei.gao@marvell.com>
	<723849F6A4B5A3408299DF1FFE37CA776C09CFC25F@BGMAIL02.nvidia.com>
Message-ID: <201106081700.48447.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 June 2011, Sachin Nikam wrote:
> 
> Does anybody knows which kernel version will have the SD 4.0 (UHS-II) support?

The SD 4.0 standard is not yet available, so it cannot be implemented.
I would assume that support will be in the kernel version following the
release of the spec, or one release later if the timing is bad.

If you already have access to the spec, feel free to post patches so
we can include it earlier.

	Arnd
