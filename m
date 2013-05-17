From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Fri, 17 May 2013 10:02:39 +0200
Subject: [PATCH] ARM: ux500: update MSP1 pinctrl defintions
In-Reply-To: <CACRpkdZj6r3=fo=72PDshHbL7oHxb6H6uGeGvRyb2+uMjoAvUg@mail.gmail.com>
References: <1368004193-21213-1-git-send-email-fabio.baltieri@linaro.org>
 <CACRpkdZj6r3=fo=72PDshHbL7oHxb6H6uGeGvRyb2+uMjoAvUg@mail.gmail.com>
Message-ID: <20130517080239.GA26583@balto.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 15, 2013 at 09:35:17PM +0200, Linus Walleij wrote:
> On Wed, May 8, 2013 at 11:09 AM, Fabio Baltieri
> <fabio.baltieri@linaro.org> wrote:
> 
> > Update MSP1 pinctrl definitions in mop500_family_pinmap by removing
> > sleep state and setting default ones as pin hogs, as those are used by
> > both ux500-msp-i2s.1 and ux500-msp-i2s.3.
> >
> > Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> 
> Applied to my ux500-pinctrl branch.

Thanks Linus,

This one was actually sort-of related to the ASoC patch to drop sleep
pin state control from the ux500 ASoC driver.  Would you be able to
check that one too?

The subject is:
  [PATCH 3/6] ASoC: ux500: Drop pinctrl sleep support

There are no dependency issues by applying this and the other in
different trees, but I'd like to close the discussion on the other one.

Thanks,
Fabio

-- 
Fabio Baltieri
