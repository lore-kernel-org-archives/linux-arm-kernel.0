From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 17 Feb 2011 23:16:00 +0800
Subject: [RFC 1/5] ARM: P2V: separate PHYS_OFFSET from platform definitions
In-Reply-To: <E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOb-00023Z-CR@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTinwQwPK7Lg4dxkLGBxvp1hz489iAB6YrSG45e75@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 5, 2011 at 4:22 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This uncouple PHYS_OFFSET from the platform definitions, thereby
> facilitating run-time computation of the physical memory offset.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Eric Miao <eric.y.miao@gmail.com>
