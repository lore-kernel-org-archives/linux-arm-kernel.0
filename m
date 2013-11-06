From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Nov 2013 15:02:34 +0000
Subject: omap2plus_defconfig build failure in v3.12
In-Reply-To: <20131106150015.GA20674@netboy>
References: <20131106150015.GA20674@netboy>
Message-ID: <20131106150234.GY16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 04:00:15PM +0100, Richard Cochran wrote:
> Is my toolchain too old, or what is going on here?

You need a later binutils for ARM - you don't have to upgrade the entire
toolchain, just the binutils.
