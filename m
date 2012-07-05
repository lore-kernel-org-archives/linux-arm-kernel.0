From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 Jul 2012 02:28:09 -0700
Subject: [PATCH v2 0/4] ARM: OMAP2+: dmtimer: cleanup related to devm
 API and clk usage
In-Reply-To: <CAC83ZvLcyRSc-X2o_05tS7R3S1s190ejDQaBOYHOK1JuknrAxA@mail.gmail.com>
References: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
 <CAC83ZvLOoUwthcv0seXeqJcuvxvhP7P500T66RHCCWvrsaPr2A@mail.gmail.com>
 <CAMQu2gxDbi191EdA0_acaJwhuAddXJ44FzVQJ=5c1Fh0PFDG4w@mail.gmail.com>
 <CAC83ZvLcyRSc-X2o_05tS7R3S1s190ejDQaBOYHOK1JuknrAxA@mail.gmail.com>
Message-ID: <20120705092809.GY1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* DebBarma, Tarun Kanti <tarun.kanti@ti.com> [120704 21:07]:
> On Thu, Jun 14, 2012 at 4:28 PM, Shilimkar, Santosh <santosh.shilimkar@ti.com> wrote:
> >
> > Just to let you know that this cleanup is essential for Benoit's OMAP4
> > hwmod cleanup
> > and OMAP5 minimal support series.
>
> This is a gentle reminder in case you have missed somehow!!
> Let me know if anything else needs to be done.

Now with the hwmod patch 2/4 pulled into cleanup-part2 from Paul,
I've also applied patch 1/4 there. Patches 3 and 4 have still some pending
comments from Kevin it seems?

Also at least patch 3 won't apply, so please check Kevin's comments
and repost patches 3 and 4 on top of cleanup-part2 at commit 74dd9ec62.

Regards,

Tony
