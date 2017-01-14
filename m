From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 14 Jan 2017 19:10:01 +0100 (CET)
Subject: [PATCH RFC] mmc: mxs-mmc: Implement CMD23 support
In-Reply-To: <CAOMZO5Czy17FytjyHP_pHHqCetDiYyOHaVOFu5hZHjAD=8rHUA@mail.gmail.com>
References: <1484414958-2665-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5Czy17FytjyHP_pHHqCetDiYyOHaVOFu5hZHjAD=8rHUA@mail.gmail.com>
Message-ID: <841116984.219625.1484417401803@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

> Fabio Estevam <festevam@gmail.com> hat am 14. Januar 2017 um 18:40 geschrieben:
> 
> 
> Hi Stefan,
> 
> On Sat, Jan 14, 2017 at 3:29 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > This patch implements support for multiblock transfers bounded
> > by SET_BLOCK_COUNT (CMD23) on the MXS MMC host driver.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> Just curious: what is the throughput gain you notice with this patch?

unfortunately i didn't see any noticeable changes on throughput.

> 
> Thanks
