From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 25 Jan 2013 08:10:05 +0000 (UTC)
Subject: [PATCH] ARM: OMAP1: fix USB host on 1710
In-Reply-To: <1359066295-20382-1-git-send-email-aaro.koskinen@iki.fi>
References: <1359066295-20382-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <alpine.DEB.2.00.1301250809500.471@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Jan 2013, Aaro Koskinen wrote:

> There is a long-standing bug that OHCI USB host controller does
> not respond on 1710, because of wrong clock definitions. See e.g.
> http://marc.info/?l=linux-omap&m=119634441229321&w=2. All register reads
> return just zeroes:

Thanks, queued for v3.8-rc fixes.

- Paul
