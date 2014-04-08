From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 08 Apr 2014 18:31:45 +0400
Subject: =?UTF-8?B?UmU6IG14MjcgcnVubmluZyB0b28gc2xvdw==?=
In-Reply-To: <CAOMZO5CCst0HHWa5JO-8-T3AHiw68FUvKRgCiVvFBu=9JdJzjw@mail.gmail.com>
References: <CAOMZO5CC1NwP14H7uuygX7ZviFJLriG41hyczzvzxYWKHJu5DQ@mail.gmail.com>
 <CAOMZO5AUemi9r_NqXXpnYZUqbqHhYnSvrnmu11voM_MZsVUa6Q@mail.gmail.com>
 <CAOMZO5CCst0HHWa5JO-8-T3AHiw68FUvKRgCiVvFBu=9JdJzjw@mail.gmail.com>
Message-ID: <1396967505.692277642@f295.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tue, 8 Apr 2014 10:49:38 -0300 ?? Fabio Estevam <festevam@gmail.com>:
> On Wed, Apr 2, 2014 at 7:38 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On Wed, Apr 2, 2014 at 7:32 PM, Fabio Estevam <festevam@gmail.com> wrote:
> >> Hi Alexander,
> >>
> >> What is the BogoMIPs value you get on mx27 running 3.14?
> >>
> >> I am running Shawn's for-next branch and it is terribly slow on a mx27pdk:
> >>
> >> sched_clock: 32 bits at 13MHz, resolution 75ns, wraps every 322929872820ns
> >> CPU identified as i.MX27, silicon rev 2.1
> >> Console: colour dummy device 80x30
> >> Calibrating delay loop (skipped), value calculated using timer
> >> frequency.. 26.60 BogoMIPS (lpj=133000)
> >>
> >> ARM9 running at 400MHz should give around 200 BogoMIPs.
> >
> > Nevermind. On a clean 3.14 kernel I get the expected value:
> >
> > Calibrating delay loop... 199.06 BogoMIPS (lpj=995328)
> >
> > So this behaviour shows up only on Shawn's branch.
> 
> Now I am running linux-next 20140408 and I am also getting the very
> slow BogoMIPS:
> 
> Calibrating delay loop (skipped), value calculated using timer
> frequency.. 26.60 BogoMIPS (lpj=133000)
> 
> Alexander,
> 
> Do you see the same on Phytec mx27 board?

Calibrating delay loop (skipped), value calculated using timer frequency.. 29.55 BogoMIPS (lpj=147777)

Can you inspect code with "git-bisect"?

---
