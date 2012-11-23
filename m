From: viresh.kumar@linaro.org (viresh kumar)
Date: Fri, 23 Nov 2012 21:27:09 +0530
Subject: [PATCH 2/8] gpio: pl061 depends on ARM
In-Reply-To: <1353683310-23654-3-git-send-email-ciminaghi@gnudd.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
 <1353683310-23654-3-git-send-email-ciminaghi@gnudd.com>
Message-ID: <CAOh2x==YCgecQi5CMJ3KRH6zxmvM2GRLR2TBcnWzznQFyHoyOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 8:38 PM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> From: Alessandro Rubini <rubini@gnudd.com>
>
> Commit dece904d (gpio: pl061: use chained_irq_* functions in irq
> handler) introduced chained_irq_enter/exit, which is only
> available for arch/arm and the driver won't compile elsewhere.
>
> The dependency is thus made explicit, because AMBA is used in the x86
> world by a PCI-to-AMBA bridge, to be submitted.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
