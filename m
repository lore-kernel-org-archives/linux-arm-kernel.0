From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Mar 2012 13:30:12 +0000
Subject: [PATCH 1/4] x86: add NO_IRQ macro
In-Reply-To: <6bda7538144dce0bf5780df3d0601147dae753b5.1330607068.git.rubini@gnudd.com>
References: <cover.1330607068.git.rubini@gnudd.com>
 <6bda7538144dce0bf5780df3d0601147dae753b5.1330607068.git.rubini@gnudd.com>
Message-ID: <20120301133012.GF7363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 02:28:36PM +0100, Alessandro Rubini wrote:
> This is needed to compile AMBA drivers. Most architectures define
> NO_IRQ as -1, and this does the same for the PC.

No.  We're getting rid of NO_IRQ, and it will be gone from AMBA stuff
probably for 3.5.
