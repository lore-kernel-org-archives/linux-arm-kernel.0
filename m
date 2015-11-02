From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Nov 2015 22:40:45 +0100
Subject: [PATCH v8 0/2] Sigma Designs Tango4 port
In-Reply-To: <56377E76.2080209@sigmadesigns.com>
References: <56377E76.2080209@sigmadesigns.com>
Message-ID: <3832780.D43HEee34D@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 November 2015 16:17:10 Marc Gonzalez wrote:
> Hello,
> 
> I've added L2 cache enabling, and booting the second core (both via
> smc calls to the firmware). I think all the "basic" features are now
> supported. Future step will be adding drivers for peripheral devices.
> (However, most of our drivers definitely do not meet the stringent
> quality requirements of the Linux kernel, and are also not DT).
> 
> I'm hoping this patch set is close to being accepted 
> 

Hi Marc,

Just to let you know about the process: The merge window is now
open, which means we are absolutely not accepting any new features
for Linux-4.4 any more but just push whatever we have in the arm-soc
tree (plus fixes for bugs we find) to Linus.

We will start merging new features after 4.4-rc1 is out, sometimes
it takes a little while before we get started. It should be no
problem to get your patches merged for 4.5 then.

	Arnd
