From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 16 May 2013 21:33:57 +0200
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <CAOMZO5AKKVeTMsXpG9wa-eeLocBStUwPjQEe3n6fRVY2aSc7Nw@mail.gmail.com>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
 <1368713639-21485-2-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5AWBi4gDJCOJf5muFuRXygQAysYCHEL+gb_LwsXiy-knA@mail.gmail.com>
 <CAOMZO5AKKVeTMsXpG9wa-eeLocBStUwPjQEe3n6fRVY2aSc7Nw@mail.gmail.com>
Message-ID: <519534A5.2070209@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On 16/05/2013 19:25, Fabio Estevam wrote:
> Sorry, the original patch is correct.
>
> i2c slowness is a different issue.

Would that be related to the timeouts I'm observing ?

http://www.spinics.net/lists/linux-i2c/msg11985.html

I didn't have the time to have a look at it yet. I was planning to hook
up a logic analyzer someday in june to debug it. It seems that there is
a 1 second timeout with each i2c message that are sent.

Don't hesitate to contact me if you need more info.

Regards,

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
