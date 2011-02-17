From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 17 Feb 2011 23:16:43 +0800
Subject: [RFC 2/5] ARM: P2V: avoid initializers and assembly using
	PHYS_OFFSET
In-Reply-To: <E1PaDOv-00023d-Gi@rmk-PC.arm.linux.org.uk>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDOv-00023d-Gi@rmk-PC.arm.linux.org.uk>
Message-ID: <AANLkTinoqNZKU3WSRf7cXG-CtpjptWhLY8c7P_z8h8f=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 5, 2011 at 4:22 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> As PHYS_OFFSET will be becoming a variable, we can't have it used in
> initializers nor assembly code. ?Replace those in generic code with
> a run-time initialization. ?Replace those in platform code using the
> individual platform specific PLAT_PHYS_OFFSET.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Eric Miao <eric.y.miao@gmail.com>
