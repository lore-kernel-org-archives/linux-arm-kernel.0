From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Oct 2014 12:23:28 +0200
Subject: [PATCH v2 0/5] pinctrl: samsung: Data structure clean-up
In-Reply-To: <1412275931-10807-1-git-send-email-tomasz.figa@gmail.com>
References: <1412275931-10807-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdY1GjDEfRH=48e24m+UcKzdPhROJBKDertS+q+e0td03g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 2, 2014 at 8:52 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> This series intends to clean up data structures used by pinctrl-samsung driver.
> More specifically, it separates initial compile time constants from data used
> at runtime, allowing unused variant data to be dropped and selected structures
> constified to improve safety.

Thanks!

The patches missed the v3.18 merge window, but I have queued them up as
the first thing to go into v3.19.

Now I need you to help me check the patch set from Abhilash so I know
what to do about that, whenever you have some time...

Yours,
Linus Walleij
