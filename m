From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Nov 2017 22:49:05 +0100
Subject: [PATCH 0/4] [v7] pinctrl: qcom: add support for sparse GPIOs
In-Reply-To: <c219c289-9cad-f96c-f766-ec28af8f078d@codeaurora.org>
References: <1510096056-13765-1-git-send-email-timur@codeaurora.org>
 <c219c289-9cad-f96c-f766-ec28af8f078d@codeaurora.org>
Message-ID: <CACRpkdbwe9+TovFYoD-W_9kabe+jsVbN6juJQBUzicq=1XDphg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 13, 2017 at 8:19 PM, Timur Tabi <timur@codeaurora.org> wrote:

> Any chance of these patches going into 4.15?

Sadly no. The merge window is open.

>  I've been making lots of
> changes, but I haven't gotten a lot of feedback.  I still think that v7 is
> more intrusive and risky than v5, with no real benefit.  But at this point,
> I just want something to be merged so that I stop thinking about it.

I am waiting for feedback from the maintainer(s) mainly Bj?rn.

There are only so many people I really trust with reviewing
qualcomm pinctrl code: Bj?rn and Stephen mainly.
Especially for the core of the driver.

>From what I have understood Qualcomm has one finger constantly
on the fast-forward button for upstreaming right now, which I think
is good (everyone should have!) but the limited number of trusted
maintainers of core infrastructure code makes bottlenecks form
around these drivers where review is really needed and deep queues
of patches form. Sorry.

If the manpower shortage persists maybe we can seek some
review from other major contributors to these drivers?
Varadarajan and Neil for example?

Yours,
Linus Walleij
