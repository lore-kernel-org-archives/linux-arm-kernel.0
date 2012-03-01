From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 13:55:56 +0000
Subject: [PATCH 2/4] sizes.h: move from asm-generic to <linux/sizes.h>
In-Reply-To: <7bbc4b3dc5a9fadfe7d8ce3f9846b03ada68424e.1330607068.git.rubini@gnudd.com>
References: <cover.1330607068.git.rubini@gnudd.com>
 <7bbc4b3dc5a9fadfe7d8ce3f9846b03ada68424e.1330607068.git.rubini@gnudd.com>
Message-ID: <201203011355.57356.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Alessandro Rubini wrote:
> sizes.h is used throughout the AMBA code and drivers, so the header
> should be available to everyone in order to driver AMBA/PrimeCell
> peripherals behind a PCI bridge where the host can be any platform
> (I'm doing it under x86).
> 
> At this step <asm-generic/sizes.h> includes <linux/sizes.h>,
> to allow a grace period for both in-tree and out-of-tree drivers.
> 
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Alan Cox <alan@linux.intel.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

For the asm-generic part of this.
