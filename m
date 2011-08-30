From: khilman@ti.com (Kevin Hilman)
Date: Mon, 29 Aug 2011 17:32:54 -0700
Subject: [RFC PATCH v2 5/6] TI81XX: Add minimal hwmod data
In-Reply-To: <1314119627-23088-1-git-send-email-hemantp@ti.com> (Hemant
	Pedanekar's message of "Tue, 23 Aug 2011 22:43:47 +0530")
References: <1314119627-23088-1-git-send-email-hemantp@ti.com>
Message-ID: <87ty8zoi15.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hemant Pedanekar <hemantp@ti.com> writes:

> This patch adds minimum required hwmod data (e.g., UARTs) for bootup of TI81XX
> devices (currently common data for TI816X and TI814X is added).
>
> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>

I haven't looked at the details yet, but just tried to boot this using
current mainline and it fails.

My first guess is that it appears to be related to a missing clkdm for
the MPU hwmod.

Kevin
