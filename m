From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 02 Aug 2010 14:52:01 +0900
Subject: Please remind 'WARNING: about Samsung merge window over'
Message-ID: <003401cb3206$d68a1fc0$839e5f40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please remind following which is from discussion about Samsung merge stuff
with Russell.

---

> > So, please send the majority of patches *before* the merge window and
> > try to avoid sending anything but fixes during the merge window itself.
> > The merge window is for code which has _already_ been merged and has
> > been in linux-next to be merged into Linus' tree.  It's not for new
> > code to be reviewed.
> 
> Next merge window, which will probably be the last I will handle for the
> S5P range, will have an earlier cut-off point. It was a big rush to get
> this lot reviewed and merged.

It also means that *NONE* of the stuff in your second pull request was
in linux-next for *any* time.  It also conflicted with my tree.  The
result of that is I'm expecting mainline to be dead for all ARM with:

arch/arm/Kconfig:883: can't open file "arch/arm/plat-s5pc1xx/Kconfig"

because of a mis-merge - and since that conflict was not picked up by
linux-next, it could not have been previously published.

For the next merge window, I will avoid reading email for the duration
of the window - which means those who are late for the merge window will
simply not have their patches and trees pulled.  This means we _will_
have time to resolve conflicts and find problems _before_ the merge
window

---

I have no more plan to merge s5p stuff for this merge window, but reviewed
here until now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
