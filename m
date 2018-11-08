From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 8 Nov 2018 09:48:55 +0000
Subject: [PATCH v2 0/9] Regenerate arm64 defconfig for current kernel
In-Reply-To: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
Message-ID: <20181108094855.GC8433@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 11:39:19PM +0100, Marc Gonzalez wrote:
> Hello ARM maintainers,
>
> v2: Improve commit message for a few patches
>
> The set of Kconfig options slowly changes with every kernel version.
> This patch series regenerates the arm64 defconfig for v4.20
> No functional change intended, except adding PINCTRL_MTK_MOORE to
> keep PINCTRL_MT7622.

Just to be sure, the end result is same as renormalising the defconfig
right ? Something like:

Commit c432c0880596 ("arm64: defconfig: renormalize based on recent additions")

Otherwise, others may try to do the same again.

--
Regards,
Sudeep
