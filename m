From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Apr 2012 12:22:01 -0700
Subject: [GIT PULL]: omap-serial updates for 3.4-rc
In-Reply-To: <CAMQu2gx6FOC2RhSYMqUEb1qqF2c+QidzRR-ZJTH_PWDL-qymUQ@mail.gmail.com>
References: <1334052148-10385-1-git-send-email-govindraj.raja@ti.com>
 <CAMrsUdKDhuDLr2=0uiQtY=r4pvmJQo=pJgERRCXySLghO7yGXA@mail.gmail.com>
 <CAMrsUdJ7wzX+Hnx_wBWNnCQz__0sMw8ruFGVWH+x3NGWG0NVQw@mail.gmail.com>
 <CAMrsUdJ9ehjC4-hChddQRnH0BtpFG3bVBTnm6zFZpU6F0za_bg@mail.gmail.com>
 <20120417173530.GC21106@atomide.com>
 <CAMQu2gx6FOC2RhSYMqUEb1qqF2c+QidzRR-ZJTH_PWDL-qymUQ@mail.gmail.com>
Message-ID: <20120417192201.GF21106@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120417 11:27]:
> On Apr 17, 2012 11:05 PM, "Tony Lindgren" <tony@atomide.com> wrote:
> >
> > > Santosh Shilimkar (1):
> > >       ARM: OMAP: serial: Fix the ocp smart idlemode handling bug
> >
> > It seems this can wait as the wake-up events are anyways broken right
> > now when we remove the muxing.
> >
> This patch has no dependency on other patches in
> this series. It is an indepedent fix for uart module wakeup which solves
> the console slugishness. It should be taken and should even go to stable.
> But I let you decide on it.

OK, will apply to fixes then with Cc stable.

Tony
