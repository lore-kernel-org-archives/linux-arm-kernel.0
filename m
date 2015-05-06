From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed, 06 May 2015 14:17:39 -0600
Subject: [PATCH v4 2/7] selftests/ftrace: install test.d
In-Reply-To: <1429656601-9254-1-git-send-email-tyler.baker@linaro.org>
References: <1429656601-9254-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <554A76E3.2050900@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 04:50 PM, Tyler Baker wrote:
> The ftrace test requires the directory test.d and all of it's contents to be
> present during execution. Use TEST_DIRS to ensure this is copied to the
> INSTALL_PATH.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> ---
>  tools/testing/selftests/ftrace/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/ftrace/Makefile b/tools/testing/selftests/ftrace/Makefile
> index 3467206..0acbeca 100644
> --- a/tools/testing/selftests/ftrace/Makefile
> +++ b/tools/testing/selftests/ftrace/Makefile
> @@ -1,6 +1,7 @@
>  all:
>  
>  TEST_PROGS := ftracetest
> +TEST_DIRS := test.d/
>  
>  include ../lib.mk
>  
> 

Applied to linux-kselftest next for 4.2

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh at osg.samsung.com | (970) 217-8978
