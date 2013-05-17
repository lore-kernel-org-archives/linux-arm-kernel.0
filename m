From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 16 May 2013 21:10:52 -0300
Subject: [PATCH 2/2] ARM: dts: imx28: Adjust i2c interrupt bindings
In-Reply-To: <519534A5.2070209@free-electrons.com>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
 <1368713639-21485-2-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5AWBi4gDJCOJf5muFuRXygQAysYCHEL+gb_LwsXiy-knA@mail.gmail.com>
 <CAOMZO5AKKVeTMsXpG9wa-eeLocBStUwPjQEe3n6fRVY2aSc7Nw@mail.gmail.com>
 <519534A5.2070209@free-electrons.com>
Message-ID: <CAOMZO5B_8TPJK9MLWyF5SiE=afKdfmg-ff6qEJOcq_R5VqhAjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Thu, May 16, 2013 at 4:33 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> Would that be related to the timeouts I'm observing ?
>
> http://www.spinics.net/lists/linux-i2c/msg11985.html
>
> I didn't have the time to have a look at it yet. I was planning to hook
> up a logic analyzer someday in june to debug it. It seems that there is
> a 1 second timeout with each i2c message that are sent.

Yes, I see the same one second timeout for each i2c transaction here.

Regards,

Fabio Estevam
