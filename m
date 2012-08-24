From: mturquette@ti.com (Mike Turquette)
Date: Fri, 24 Aug 2012 12:12:34 -0700
Subject: [PATCH v4 1/2] ARM: PRIMA2: convert to common clk and finish full
 clk tree
In-Reply-To: <CAGsJ_4xAoa_w9BYKvtFS7=TdgXY6QReb7ja9QUWn=njbEq98vg@mail.gmail.com>
References: <1345444957-16039-1-git-send-email-Barry.Song@csr.com>
 <CAGsJ_4xAoa_w9BYKvtFS7=TdgXY6QReb7ja9QUWn=njbEq98vg@mail.gmail.com>
Message-ID: <20120824191234.5710.5552@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Barry Song (2012-08-21 02:44:02)
> Hi Mike,
> 
> can you pls merge these two patches as our discussion at:
> 
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/178760
> 
> our following many patches depend on these two.
> 

Done!  Sorry about the long wait but I've been traveling for work and
got sidetracked.  I'm catching up on clk patches now and will push out
my clk-next branch towards 3.7 this evening.

Regards,
Mike

> -barry
> 
> 2012/8/20 Barry Song <Barry.Song@csr.com>:
> > From: Binghua Duan <Binghua.Duan@csr.com>
> >
> > Commit 02c981c07bc95ac1e only implements a little part of primaII clk tree
> > due to common clk framework was not ready at that time.
> > This patch converts the old driver to common clk and finish the full clk
> > tree.
> >
> > Signed-off-by: Binghua Duan <Binghua.Duan@csr.com>
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > ---
> >  -v4: fix a typo
