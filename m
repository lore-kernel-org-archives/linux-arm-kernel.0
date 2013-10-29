From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Oct 2013 10:39:45 -0700
Subject: [PATCH 2/4] ARM: msm: Remove 7x00 support
In-Reply-To: <20131029170817.GA13047@fifo99.com>
References: <1382993006-27359-1-git-send-email-davidb@codeaurora.org>
 <1382993006-27359-3-git-send-email-davidb@codeaurora.org>
 <20131029132043.GA28165@fifo99.com>
 <CAOesGMhg8HN4Su9FXSeoAgmH6NVKXW+wmnreUvWH+1G6GWkkaA@mail.gmail.com>
 <20131029170817.GA13047@fifo99.com>
Message-ID: <CAOesGMgKbreaqFTGvC=_T6-i7uejfXAPNU8LmMpgDMqeEwYxZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 10:08 AM, Daniel Walker <dwalker@fifo99.com> wrote:

> Personally I think splitting mach- stuff isn't very useful or
> interesting.. There's just no technical reason for it, for example x86
> and x86_64 was a win from my perspective , there's a lot more reason to
> keep similar things together than to split things up.

There are definitely valid technical reasons for it; the old and new
platforms share no code, and the legacy platforms are unlikely to be
updated to modern infrastructure anytime soon. Other platforms are
managed in similar manners, such as OMAP, imx/mxs, etc.


-Olof
