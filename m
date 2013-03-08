From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 8 Mar 2013 12:42:03 +0800
Subject: [PATCH] clk:SPEAr1340: Correct parent clock configuration
In-Reply-To: <9c65c93de3e7269bfc6e31bcdddc2ecd64338761.1362639296.git.vipulkumar.samar@st.com>
References: <9c65c93de3e7269bfc6e31bcdddc2ecd64338761.1362639296.git.vipulkumar.samar@st.com>
Message-ID: <CAOh2x=nOgvPzojJ_xCgpCbqkiK4W9ovGm-j5shdjadhfCSOA3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 7, 2013 at 3:05 PM, Vipul Kumar Samar
<vipulkumar.samar@st.com> wrote:
> This patch corrects wrongly configured parent clock for following
> devices:
>
>    * Video enc/decoder
>    * Video ip
>    * Pin control
>    * ACP
>    * camx
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> Reviewed-by: Shiraz Hashim <shiraz.hashim@st.com>
> ---
>  drivers/clk/spear/spear1340_clock.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
