From: tony@atomide.com (Tony Lindgren)
Date: Tue, 2 Feb 2016 10:47:34 -0800
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <20160202180555.GW19432@atomide.com>
References: <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
 <Pine.LNX.4.44L0.1602021112320.1653-100000@iolanthe.rowland.org>
 <20160202164910.GV19432@atomide.com>
 <20160202180555.GW19432@atomide.com>
Message-ID: <20160202184733.GX19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160202 10:07]:
> 
> The following seems to make things behave for me. Now the
> question is.. Does it have some undesired side effects?

The side effect is that it breaks PM runtime for devices
during runtime..

Regards,

Tony
