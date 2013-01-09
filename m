From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 10 Jan 2013 08:09:30 +1300
Subject: [PATCH 1/4] arm: vt8500: Add support for Wondermedia WM8750/WM8850
In-Reply-To: <CAOesGMj6XTuW9tPqYnawPvO-wJBd7s5M5xTfdvQcmEioHw=Pnw@mail.gmail.com>
References: <1356650452-16559-1-git-send-email-linux@prisktech.co.nz>
 <1356650452-16559-2-git-send-email-linux@prisktech.co.nz>
 <1357712039.774.0.camel@gitbox>
 <CAOesGMj6XTuW9tPqYnawPvO-wJBd7s5M5xTfdvQcmEioHw=Pnw@mail.gmail.com>
Message-ID: <1357758570.27076.8.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-08 at 22:30 -0800, Olof Johansson wrote:
> On Tue, Jan 8, 2013 at 10:13 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
> > On Fri, 2012-12-28 at 12:20 +1300, Tony Prisk wrote:
> >> This patch adds support for the WM8750 (ARMv6) and WM8850 (ARMv7).
> >>
> >> Common features across all SoCs are split into ARCH_VT8500 and
> >> unique features are specified by each SoC option.
> >>
> >> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> >
> >
> > Hi Arnd, Olof,
> >
> > Haven't heard anything re: this patch series. Problem?
> 
> Nope, just wasn't sure if you would send a git pull request or if you
> wanted them applied.
> 
> I'm out of time for tonight, but I'll look closer at them (and apply
> them if all OK) tomorrow.
> 
> 
> -Olof

I'm quite happy to send a pull request if that's what you prefer.

Generally people have just taken the patches straight from email, so
everytime I've done a pull-request I get a reply back saying the patches
have already been applied.

Is there some 'rule' around pull-requests vs emailed patches?
Should patches in pull-requests have Ack'd lines already?

Regards
Tony P
