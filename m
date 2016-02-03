From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 3 Feb 2016 11:25:23 +0100
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <CAPDyKFqLi8xOUeoxUTAmif5QrOjVpV_2CDLv4hjO_C9iOnv+5Q@mail.gmail.com>
References: <20160201232833.GR19432@atomide.com>
 <Pine.LNX.4.44L0.1602011844540.2869-100000@netrider.rowland.org>
 <20160202030533.GT19432@atomide.com>
 <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
 <CAPDyKFras1o13WBZzaZ_Snnj5TBQQFWKr=PtCjUvwe+yGPQn9w@mail.gmail.com>
 <20160202163536.GU19432@atomide.com>
 <CAPDyKFosQjkHDVSvy67+hstjjFseXQP5WYXrJE19GgVFYJ099w@mail.gmail.com>
 <20160202234145.GC19432@atomide.com>
 <CAPDyKFqLi8xOUeoxUTAmif5QrOjVpV_2CDLv4hjO_C9iOnv+5Q@mail.gmail.com>
Message-ID: <CAPDyKFqSVZffQ7WNZqn9qSRibsCgG2rY26z_97agL+LhQRVGcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> I don't see the problem, but of course you know omap for better than I do.
>
> So if you are concerned about this, perhaps adding a dev_dbg print
> when the omap hwmod's ->runtime_suspend() callback returns zero could

/s/runtime_suspend/runtime_resume

Kind regards
Uffe
