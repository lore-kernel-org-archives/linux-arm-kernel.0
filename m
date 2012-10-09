From: viresh.kumar@linaro.org (viresh kumar)
Date: Tue, 9 Oct 2012 23:12:45 +0530
Subject: [PATCH 08/11] fsmc/nand: Use relaxed variants of io accessors
In-Reply-To: <88484dbae96f7db42ce615552a4c758844a5e6cc.1349778821.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <88484dbae96f7db42ce615552a4c758844a5e6cc.1349778821.git.vipin.kumar@st.com>
Message-ID: <CAOh2x=nbiYCvwpiuVikcKB6=M2m0Z031XromT3jcFWOurupZZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 4:14 PM, Vipin Kumar <vipin.kumar@st.com> wrote:
> Use relaxed variants of readl/writel accessors. readl/writel io accessors use
> explicit dsb instruction which causes stalls in the processor core resulting
> several cycles of delay for each access
>
> Use relaxed variants where ever possible. This also results in an improved
> read/write performance.

Good change.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
