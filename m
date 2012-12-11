From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 11 Dec 2012 09:55:08 +0530
Subject: [PATCH v4 1/7] DMA: PL330: use prefix in reg names to build under
 x86
In-Reply-To: <1355146956-6009-2-git-send-email-ciminaghi@gnudd.com>
References: <1355146956-6009-1-git-send-email-ciminaghi@gnudd.com>
 <1355146956-6009-2-git-send-email-ciminaghi@gnudd.com>
Message-ID: <CAJe_ZhfE9-kvB9s5=VZ5tgzXa7GsQj_1rt232aCsrfJ-KiTP1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 December 2012 19:12, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> From: Alessandro Rubini <rubini@gnudd.com>
>
>     This driver would not compile if ARM_AMBA is selected under x86,
>     because "CS" and "DS" are already defined there.  But AMBA
>     is used in the x86 world by a PCI-to-AMBA bridge, to be submitted.
>
>     The patch just adds the "PL330_" prefix to all registers,
>     so it can be built by randomconfig after ARM_AMBA appears within x86.
>     No other technical changes have been performed.
>     The patch was build-tested only.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> [Davide Ciminaghi <ciminaghi@gnudd.com>: only registers prefixed]
> Signed-off-by: Davide Ciminaghi <ciminaghi@gnudd.com>
> ---

 Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

Thanks.
