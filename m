From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 05 Jul 2012 10:23:52 +0100
Subject: [PATCH 1/2] ARM: vexpress: add debug UARTs to DEBUG_LL kconfig
 choice
In-Reply-To: <1341414076-20895-1-git-send-email-will.deacon@arm.com>
References: <1341414076-20895-1-git-send-email-will.deacon@arm.com>
Message-ID: <1341480232.1173.22.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-07-04 at 16:01 +0100, Will Deacon wrote:
> This patch avoids probing the various possible UART locations on the
> different Versatile Express motherboards and instead adds entries into
> the DEBUG_LL kconfig choice for the two possible memory maps.

I wrote similar thing (keeping the autodetection as one of the options)
some time ago, but Russell didn't like it (because it wasn't DEBUG_LL
choice) and I didn't have time to rework it for 3.5 merge window. Will
get this out this time.

Pawe?
