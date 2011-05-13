From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 May 2011 17:08:38 +0200
Subject: [PATCH 0/6] use AMBA periphid for hardcoding
In-Reply-To: <1300874614-14675-1-git-send-email-linus.walleij@stericsson.com>
References: <1300874614-14675-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <BANLkTim8Pw_YXX0eQPkoju9or7NDGOuZrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/3/23 Linus Walleij <linus.walleij@stericsson.com>:

> These patches swithches the semantics of the optional AMBA periphid
> field from fallback (when hardware ID is not found) to hardcoding
> (overriding hardware ID) when used in platform data.

Russell have you had a chance to look at this?

I think 6827/1 and 6828/1 are just normal clean-up, whereas
6829/1 thru 6832/1 is the controversial part, but I'd like to stress
that it's solving a major issue for us, and I know for sure that the
silicon will not be re-spun to solve the issue :-(

I *have* contacted the hardware RTL engineers about it and kindly
asked them to keep periphids in sync in the future.

Yours,
Linus Walleij
