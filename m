From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 13 Feb 2014 13:11:45 +0000
Subject: [PATCH 06/12] mfd: vexpress-sysreg: Add labels to gpio banks
In-Reply-To: <CACRpkdZjrCdhyBMF2WbDCnHuuMSpcpwiPx2k555PY3yBwdc1aw@mail.gmail.com>
References: <1392138636-29240-1-git-send-email-pawel.moll@arm.com>
 <1392138636-29240-7-git-send-email-pawel.moll@arm.com>
 <CACRpkdZjrCdhyBMF2WbDCnHuuMSpcpwiPx2k555PY3yBwdc1aw@mail.gmail.com>
Message-ID: <1392297105.848.82.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-13 at 13:08 +0000, Linus Walleij wrote:
> On Tue, Feb 11, 2014 at 6:10 PM, Pawel Moll <pawel.moll@arm.com> wrote:
> 
> > ... so debugfs interfaces are easier to use.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Alexandre Courbot <gnurou@gmail.com>
> > Cc: Samuel Ortiz <sameo@linux.intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> 
> This doesn't apply to the v3.14-rc1-based GPIO tree. Can you rebase it
> with Lee's ACK so I can apply this?

Uh, it won't apply. This series depends on the one reworking sysregs.
I'll send them separately once it's ready. Sorry about confusion and
thanks for trying!

Pawel
