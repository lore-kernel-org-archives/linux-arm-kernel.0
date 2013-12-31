From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 31 Dec 2013 11:13:42 -0800
Subject: [PATCH RESEND 1/4] clk: clk-s2mps11: Refactor for including
 support for other MFD clocks
In-Reply-To: <20131231160916.GG31886@sirena.org.uk>
References: <1383202124-1775-1-git-send-email-tushar.behera@linaro.org>
 <1388053141-30085-1-git-send-email-tushar.behera@linaro.org>
 <1388053141-30085-2-git-send-email-tushar.behera@linaro.org>
 <20131229221723.12054.40917@quantum>
 <CAHbNUh0tJHXv52bA9hBDZMH0Pi+x9uC=LojcvgS=ONnCgEmVTA@mail.gmail.com>
 <20131231160916.GG31886@sirena.org.uk>
Message-ID: <20131231191342.12054.42268@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mark Brown (2013-12-31 08:09:16)
> On Mon, Dec 30, 2013 at 09:33:50AM +0530, Tushar Behera wrote:
> 
> > Commit 1b1ccee1e821 "mfd: s2mps11: Fix build after regmap field rename
> > in sec-core.c" is also touching this file, which is in Mark's tree
> > right now. If I rebase
> 
> It's been in Linus' tree for a while now.

OK, so I merged the two patches into clk-next, then merged clk-next into
next-20131224 and the merge is super trivial to resolve. So I propose
that we just let it get resolved in linux-next the usual way.

Any objections? If not I'll take these two patches into clk-next.

Regards,
Mike
