From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Aug 2013 21:36:40 +0200
Subject: [PATCH 11/35] cpufreq: dbx500: use
 cpufreq_table_validate_and_show()
In-Reply-To: <e343e827df7be24f11ecdaf849f2874bf1ba4b24.1375964117.git.viresh.kumar@linaro.org>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
 <e343e827df7be24f11ecdaf849f2874bf1ba4b24.1375964117.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkda29WcHePh00w_7N3B1OtGh=-i=1_PyB4MNhy=YJ-nxyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 8, 2013 at 3:48 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Lets use cpufreq_table_validate_and_show() instead of calling
> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
