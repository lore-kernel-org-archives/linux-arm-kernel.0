From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Jan 2012 09:43:02 -0800
Subject: [PATCH] ARM: OMAP: fix erroneous mmc2 clock change on mmc3 setup
In-Reply-To: <CANOLnONJgEJehOiH0_0AUWnAu62K-8A_cmv4UW0v=dwoQnn62w@mail.gmail.com>
References: <1324168547-26569-1-git-send-email-notasas@gmail.com>
 <CANOLnONJgEJehOiH0_0AUWnAu62K-8A_cmv4UW0v=dwoQnn62w@mail.gmail.com>
Message-ID: <20120120174302.GR22818@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [120120 08:51]:
> Hi Tony,
> 
> Would be nice to have this for -rc as this used to work several
> releases back when hsmmc23_before_set_reg() was checking for a
> regulator, which wasn't set for MMC3 so the function would return
> early, not causing the problem it causes now.

Yeah this looks like a fix. I'll take a look next week as I'll
be travelling.

Tony
