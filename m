From: viresh.kumar@linaro.org (viresh kumar)
Date: Fri, 23 Nov 2012 21:21:44 +0530
Subject: [PATCH 1/8] DMA: PL330: use prefix in reg names to build under x86
In-Reply-To: <1353683310-23654-2-git-send-email-ciminaghi@gnudd.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
 <1353683310-23654-2-git-send-email-ciminaghi@gnudd.com>
Message-ID: <CAOh2x=ncwZNQDKvFia_yrCmmDJ1Kkk+wP4fhcdeo_YtE97ridA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 8:38 PM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> From: Alessandro Rubini <rubini@gnudd.com>
>
> This driver would not compile if ARM_AMBA is selected under x86,
> because "CS" and "DS" are already defined there.  But AMBA
> is used in the x86 world by a PCI-to-AMBA bridge, to be submitted.
>
> The patch adds the "PL330_" prefix to all register and bit fields,
> so it can be built by randomconfig after ARM_AMBA appears within x86.
>
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Hi Davide,

Its impossible to review due to obvious reasons :)

Though git provides an option to people to review such stuff easily.

git diff HEAD^.. --word-diff

and HEAD being the commit in discussion.

Problem, is people reviewing it need to apply it and not everybody
can do that. Don't know if adding this diff after the three --- line,
which form the non-commit log would be the right solution ?

--
viresh
