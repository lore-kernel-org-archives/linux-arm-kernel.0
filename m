From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 13 Sep 2013 15:18:41 +0200
Subject: [PATCH 063/228] cpufreq: dbx500: Use generic cpufreq routines
In-Reply-To: <a3970f9a04fd061a7ad476f983e10a8768c89fd0.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <a3970f9a04fd061a7ad476f983e10a8768c89fd0.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdbgpuuSpHpu2-pEvOjd3hB-cqn62Ui6__VFbyNHDLu6+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 3:00 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
> and .attr. So its better if we have generic routines for them which can be used
> by cpufreq drivers then.
>
> This patch uses these generic routines for this driver.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by. It feels like I acked this before...

Yours,
Linus Walleij
