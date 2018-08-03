From: evgreen@chromium.org (Evan Green)
Date: Fri, 3 Aug 2018 15:59:22 -0700
Subject: [PATCH v7 3/8] interconnect: Add debugfs support
In-Reply-To: <20180731161340.13000-4-georgi.djakov@linaro.org>
References: <20180731161340.13000-1-georgi.djakov@linaro.org>
 <20180731161340.13000-4-georgi.djakov@linaro.org>
Message-ID: <CAE=gft5Fkp485u6NVDf_cOfxmUgmLM3KtoXZHe0u77o8nFJLmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 9:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Add a functionality to provide information about the current constraints
> per each node and provider.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  drivers/interconnect/core.c | 78 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>

Reviewed-by: Evan Green <evgreen@chromium.org>
