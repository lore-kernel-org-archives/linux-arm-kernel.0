From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 29 Aug 2013 11:20:02 -0700
Subject: [GIT PULL for v3.12] pull request from pxa git tree for hi3xxx
In-Reply-To: <CAD6h2NSz6yroFd2Uxt+0DUSc7yyc68caWm6P6RdaxshiR2MCmA@mail.gmail.com>
 (Haojian Zhuang's message of "Wed, 28 Aug 2013 21:18:38 +0800")
References: <CAD6h2NSz6yroFd2Uxt+0DUSc7yyc68caWm6P6RdaxshiR2MCmA@mail.gmail.com>
Message-ID: <8738ps1hrh.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@linaro.org> writes:

> Hi,
>
> Please help to merge hi3xxx tag from pxa git tree. It's used to enable
> Hi3xxx SoC.
>
> The debug ll patch isn't included in this patch set since it's going
> through Russell's tree.
>
> The clock patch isn't included also. Since it's going through Mike's clock tree.

It's helpful if you more be specific about the dependencies and their
status here.  This series uses new clock bindings which are in theory
through Mike's tree, but I'm not sure if they're already merged, queued,
under review etc.  I have to go hunting myself, which could be avoided
if more detail was given here.

Also, you posted this pull request 8 minutes after you posted v9 of your
series, so obviously that didn't give a whole lot of time for reviewers
to have a look.  Having a brief look at v9 for the DT issues I raised
v7, it seems there are still problems there.

All of that to say, I'm afraid this stuff is not going to make it for
v3.12.

Kevin 
