From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Nov 2012 10:47:38 +0100
Subject: [PATCH 00/14] ARM: SPEAr: DT updates
In-Reply-To: <CAKohpokMUTQja6tCz1RmKXFgu+X7MGFAi1+UWLgKhpViOuiMSA@mail.gmail.com>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <201211121521.58766.arnd@arndb.de>
 <CAKohpom0kMjuHx5jO-LTPKQhy_-r4khKi7UBPB_O-50K42FOeQ@mail.gmail.com>
 <20121121202405.GA15549@quad.lixom.net>
 <CAKohpokMUTQja6tCz1RmKXFgu+X7MGFAi1+UWLgKhpViOuiMSA@mail.gmail.com>
Message-ID: <CACRpkdbsDzYuUJpVAS=ujv7EEq_nA-kAzHnN1F0d3WqoMEeCUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 4:19 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Last week i had chat with Arnd and Linus over Hangout, and following is
> the status:
> - Dependency patch of pinctrl is:
>
> commit 4ddb1c295752252f61670e35c791bf16e58bbce6
> Author: Viresh Kumar <viresh.kumar@linaro.org>
> Date:   Sat Oct 27 15:21:39 2012 +0530
>
>     ARM: SPEAr: Add plgpio node in device tree dtsi files
>
> And is already in pinctrl/devel branch. And this branch is stable as per Linus.

Well, famous last words. But that commit and below should
be perfectly fine to pull into ARM SoC if need be. As long
as we don't create too big a cobweb ... with linux-next not
being done this week I'd watch it for this kind of stuff at this
stage.

Yours,
Linus Walleij
