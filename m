From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Mar 2013 10:45:03 +0000
Subject: [PATCH v2 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <CAHTX3d+J370kD=1Eeuo_srKCngFizuYV=HtmgYsHfXvG80O01w@mail.gmail.com>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <201303271000.47614.arnd@arndb.de>
 <CAHTX3d+J370kD=1Eeuo_srKCngFizuYV=HtmgYsHfXvG80O01w@mail.gmail.com>
Message-ID: <201303271045.03736.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Michal Simek wrote:
> BTW: Have you added to zero day testing system arm multi platform
> or is there any arm multi platform config which developer should run
> to be sure that armv7 code can be compiled for armv6 and also
> that there is no problem with symbols?

I'm only occasionally doing build tested right now, not all the time.

	Arnd
