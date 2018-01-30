From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 Jan 2018 23:19:52 +0100
Subject: [PATCH v2 0/3] Device tree fixes for Axentia TSE-850 and Nattis
In-Reply-To: <20180118114616.6639-1-peda@axentia.se>
References: <20180118114616.6639-1-peda@axentia.se>
Message-ID: <20180130221952.GN2809@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/2018 at 12:46:13 +0100, Peter Rosin wrote:
> Hi!
> 
> Here's a series that is of the "documentation" kind. It fixes things
> that don't really need fixing, but the fixes are correct none-the-less
> and should prevent possible confusion.
> 
> Changes since v1:
> 
> - One more fix added to patch 1/3. The size of the rootfs partition
>   should be 504MB, as the flash is 512MB total.
> 
> Sorry for the noise.
> 

All applied. I'm planning to send that for 4.17 as they are not urgent.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
