From: viresh.kumar@linaro.org (viresh kumar)
Date: Fri, 23 Nov 2012 21:26:41 +0530
Subject: [PATCH 4/8] watchdog: sp805_wdt depends on ARM
In-Reply-To: <1353683310-23654-5-git-send-email-ciminaghi@gnudd.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
 <1353683310-23654-5-git-send-email-ciminaghi@gnudd.com>
Message-ID: <CAOh2x=mL8NzQuwjpuehbq3TiRp5dddS4fwYRT7OSQVicfLGZyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 8:38 PM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> From: Alessandro Rubini <rubini@gnudd.com>
>
> The SP805 driver is only used by the Spear machines, and uses
> writel_relaxed, which is not available on all architectures.
>
> The dependency from CONFIG_ARM avoids compilation problems under
> randomconfig when CONFIG_ARM_AMBA is enabled for x86 builds.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> Signed-off-by: Davide Ciminaghi <ciminaghi@gnudd.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
