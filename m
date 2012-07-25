From: attila@kinali.ch (Attila Kinali)
Date: Wed, 25 Jul 2012 09:52:18 +0200
Subject: [PATCH] ARM: mxs: Adjust of_find_property()
In-Reply-To: <1343028538-13891-1-git-send-email-festevam@gmail.com>
References: <1343028538-13891-1-git-send-email-festevam@gmail.com>
Message-ID: <20120725095218.5952d1a888bbc1337d4e73bc@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Jul 2012 04:28:58 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit 475d00 (of: Improve prom_update_property() function) prom_update_property requires
> two arguments.
> 
> Fix this in order to get rid of the following build error:
> 
> arch/arm/mach-mxs/mach-mxs.c:175:4: error: too many arguments to function 'prom_update_property'

The same fix has been already send by Shawn Guo[1] and Lauri Hintsala[2]

			Attila Kinali

[1] http://article.gmane.org/gmane.linux.kernel.next/23330
[2] http://article.gmane.org/gmane.linux.ports.arm.kernel/177465

-- 
The trouble with you, Shev, is you don't say anything until you've saved
up a whole truckload of damned heavy brick arguments and then you dump
them all out and never look at the bleeding body mangled beneath the heap
		-- Tirin, The Dispossessed, U. Le Guin
