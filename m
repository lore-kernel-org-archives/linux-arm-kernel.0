From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Nov 2014 12:53:18 +0100
Subject: [RFC PATCH v2 1/4] arm64: defconfig: increase NR_CPUS range to
 2-128
In-Reply-To: <1416605010-10442-2-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1416605010-10442-2-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <3519779.ILzEnWe9lP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 November 2014 02:53:27 Ganapatrao Kulkarni wrote:
> Raising the maximum limit to 128. This is needed for Cavium's
> Thunder system that will have 96 cores on Multi-node system.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
> 

Could we please raise the compile-time limit to the highest number that
you are able to boot successfully on some existing machine?

There isn't much point in doubling this every few months.

	Arnd
