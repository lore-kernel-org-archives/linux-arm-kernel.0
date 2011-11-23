From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 23 Nov 2011 08:55:39 -0800
Subject: [PATCH] ARM: tegra: remove declaration of
 tegra_assert_system_reset in board.h
In-Reply-To: <1322046284.27165.1.camel@phoenix>
References: <1322046284.27165.1.camel@phoenix>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174F08C6C7@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Axel Lin wrote at Wednesday, November 23, 2011 4:05 AM:
> commit b2f745 "ARM: restart: tegra: use new restart hook"
> changed tegra_assert_system_reset to be static but forgot to
> remove the declaration in arch/arm/mach-tegra/board.h.

Please see:

http://www.spinics.net/lists/arm-kernel/msg148932.html

Thanks.

-- 
nvpublic
