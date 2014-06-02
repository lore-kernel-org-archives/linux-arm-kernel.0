From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 2 Jun 2014 13:25:53 +0530
Subject: [PATCH Resend 6/8] ARM: spear: Staticize spear13xx_io_desc
In-Reply-To: <1401446261-22423-6-git-send-email-sachin.kamat@linaro.org>
References: <1401446261-22423-1-git-send-email-sachin.kamat@linaro.org>
 <1401446261-22423-6-git-send-email-sachin.kamat@linaro.org>
Message-ID: <CAKohponHzzXbyYBj-W8Me5yWuic4Em34bJGUr5d0FGRHM27wpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 May 2014 16:07, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> 'spear13xx_io_desc' is used only in this file.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Shiraz Hashim <shiraz.linux.kernel@gmail.com>
> Cc: spear-devel at list.st.com
> ---
>  arch/arm/mach-spear/spear13xx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
