From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 20 Aug 2012 09:06:34 +0100
Subject: [PATCH 13/22] ARM: ux500: Fork MSP platform registration for
 step-by-step DT enablement
In-Reply-To: <CACRpkdaem6t3mvy-_9e=GEgwWoeBQSoX3Hf1L=hjWsvLJdsVAQ@mail.gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-14-git-send-email-lee.jones@linaro.org>
 <CACRpkdaem6t3mvy-_9e=GEgwWoeBQSoX3Hf1L=hjWsvLJdsVAQ@mail.gmail.com>
Message-ID: <20120820080632.GD8450@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 01:13:49PM +0200, Linus Walleij wrote:
> On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > We've done this before and it worked well last time. Here we're
> > duplicating a complex registration function to ease the process
> > of enabling it for Device Tree. As there are quite a few steps
> > taken during the registration process, it makes sense to break
> > them up into more manageable chunks. This patch will aid us.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> I understand you have used this approach before so:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Does this comment take back your previous one:

NOTE: it seems this patch set contains some churn. First you
add in the forked device init, put in a big chunk of code and
then in the *same* patch set delete it again. It's not like
we're dying to see all the development history... can this
be squashed down a bit?

... hence leave the patch-set as it is?

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
