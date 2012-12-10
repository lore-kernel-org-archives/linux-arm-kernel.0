From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Dec 2012 16:27:29 +0100
Subject: Your kernel patches for the Marvell Mirabox
In-Reply-To: <20121210140202.GI21694@titan.lakedaemon.net>
References: <50C4AC68.7090709@gmail.com>
 <20121210140202.GI21694@titan.lakedaemon.net>
Message-ID: <20121210162729.21f2f053@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Mon, 10 Dec 2012 09:02:02 -0500, Jason Cooper wrote:

> In u-boot you'll need to change the boardid environment variable to
> 0xffffffff, which needs to be in unsigned integer notation, 4294967295.

I'm not sure this is strictly necessary. I've never done that on any
Marvell U-Boot's and I'm happily booting DT-only kernels.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
