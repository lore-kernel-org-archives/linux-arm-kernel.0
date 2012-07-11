From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jul 2012 18:51:22 +0200
Subject: [PATCH 4/9] ARM: vexpress: Initial common clock support
In-Reply-To: <1342013791-19516-5-git-send-email-pawel.moll@arm.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-5-git-send-email-pawel.moll@arm.com>
Message-ID: <CACRpkdZGVgO-1jnfK=fpo73ryLDe05R0_hghwBxzDfbBK9jBRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

can you please move the vexpress clock implementation to
drivers/clk/versatile/clk-vexpress.c as per the pattern from the
Integrator rework?

Clock drivers go into the drivers/* hierarchy just like any other
driver these days.

You need to base that on top of the Integrator patches of course,
these are here, but I think Mike did some alterations though:
http://git.kernel.org/?p=linux/kernel/git/linusw/linux-integrator.git;a=shortlog;h=refs/heads/integrator-clk

Yours,
Linus Walleij
