From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 23 Nov 2012 18:29:24 +0530
Subject: [PATCH 1/1] mfd: Simplify IRQ domain registration code in STMPE
In-Reply-To: <1353675386-6749-1-git-send-email-lee.jones@linaro.org>
References: <1353675386-6749-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CAKohponsfpvYgcuJugfYLf6uADGcbqjUAG_Yce2wmn=n_SoCkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 November 2012 18:26, Lee Jones <lee.jones@linaro.org> wrote:
> Historically, a driver would have to decide whether it required
> a Linear or Legacy IRQ domain when registering one. This can end
> up as quite a lot of code. A new Simple call now exists which
> simplifies this process. Let's make use of it here.
>
> Samuel Ortiz <sameo@linux.intel.com>

Cc: ?

> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
