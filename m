From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Apr 2015 12:41:46 +0100
Subject: Standard/common method for booting secondary cores
In-Reply-To: <553580F7.7040903@free.fr>
References: <553580F7.7040903@free.fr>
Message-ID: <20150421114146.GA10164@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> With the current push for CONFIG_ARCH_MULTIPLATFORM,
> I'm wondering if things like starting secondary cores
> have been "standardized"/factorized to the point where
> I can just use some default implementation?

PSCI [1] exists for this, and is supported by Linux.

Mark.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
