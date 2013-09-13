From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 15:19:20 +0200
Subject: [PATCH 099/228] cpufreq: dbx500: don't initialize part of policy
 that is set by core too
In-Reply-To: <43f3fedcc13b4cd8a016f2dbbc91936423420cb8.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <43f3fedcc13b4cd8a016f2dbbc91936423420cb8.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkda=vzV1k5sJbnZSJHpEuEGwaHN_qi_-QzU79QoyoHse2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 3:00 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Many common initializations of struct policy are moved to core now and hence
> this driver doesn't need to do it. This patch removes such code.
>
> Most recent of those changes is to call ->get() in the core after calling
> ->init().
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
