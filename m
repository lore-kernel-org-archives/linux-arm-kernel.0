From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 21 Jan 2012 09:26:03 +0900
Subject: [PATCH] ARM: move CP15 definitions to separate header file
In-Reply-To: <E1RoBJw-0005UP-By@rmk-PC.arm.linux.org.uk>
References: <E1RoBJw-0005UP-By@rmk-PC.arm.linux.org.uk>
Message-ID: <00fd01ccd7d3$4287f760$c797e620$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote:
> 
> Avoid namespace conflicts with drivers over the CP15 definitions by
> moving CP15 related prototypes and definitions to a private header
> file.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

For exynos:
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
