From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Aug 2012 13:18:55 +0200
Subject: [PATCH 17/22] ARM: ux500: Remove platform registration of MSP
 devices
In-Reply-To: <1344527268-5964-18-git-send-email-lee.jones@linaro.org>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-18-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdayCNFq9_evUdyNTuXaJacnk1sHqOqebnOgvLYhYqxj8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:

> This patch removes platform device registration of all 4 MSP
> devices. It also takes care of all redundant infrastructure now
> that each of the ux500 audio components have been Device Tree
> enabled.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

NOTE: it seems this patch set contains some churn. First you
add in the forked device init, put in a big chunk of code and
then in the *same* patch set delete it again. It's not like
we're dying to see all the development history... can this
be squashed down a bit?

Yours,
Linus Walleij
