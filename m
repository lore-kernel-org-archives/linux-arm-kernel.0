From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 10 Dec 2012 11:42:38 -0500
Subject: Your kernel patches for the Marvell Mirabox
In-Reply-To: <20121210162729.21f2f053@skate>
References: <50C4AC68.7090709@gmail.com>
 <20121210140202.GI21694@titan.lakedaemon.net>
 <20121210162729.21f2f053@skate>
Message-ID: <20121210164238.GJ21694@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 04:27:29PM +0100, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Mon, 10 Dec 2012 09:02:02 -0500, Jason Cooper wrote:
> 
> > In u-boot you'll need to change the boardid environment variable to
> > 0xffffffff, which needs to be in unsigned integer notation, 4294967295.
> 
> I'm not sure this is strictly necessary. I've never done that on any
> Marvell U-Boot's and I'm happily booting DT-only kernels.

Yeah, I know it helped the topkick boot up.  I probably needed this for
kirkwood_defconfig, which includes support for legacy boards.
mvebu_defconfig wouldn't need it then, since everything in mvebu is DT.
Thanks for clarifying the point.

hth,

Jason.
