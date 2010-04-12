From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 19:50:24 +0100
Subject: [RFC PATCH] arm: kconfig: push down CACHE_L2X0
In-Reply-To: <1270236996.26326.7.camel@c-dwalke-linux.qualcomm.com>
References: <1270236996.26326.7.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100412185024.GH3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 02, 2010 at 12:36:36PM -0700, Daniel Walker wrote:
> Does it make sense to push down this value? It looks like it's just
> adding more and more sub-architectures .. Is the method below
> acceptable?

Yes, but please name it HAVE_CACHE_L2X0.
