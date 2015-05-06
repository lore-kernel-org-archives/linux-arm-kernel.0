From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed, 06 May 2015 14:18:52 -0600
Subject: [PATCH v4 3/7] selftests/kdbus: install kdbus-test
In-Reply-To: <1429656651-9427-1-git-send-email-tyler.baker@linaro.org>
References: <1429656651-9427-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <554A772C.8000904@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 04:50 PM, Tyler Baker wrote:
> Set TEST_PROGS so that kdbus-test is installed.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> ---
>  tools/testing/selftests/kdbus/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kdbus/Makefile b/tools/testing/selftests/kdbus/Makefile
> index de8242f..94ea75b 100644
> --- a/tools/testing/selftests/kdbus/Makefile
> +++ b/tools/testing/selftests/kdbus/Makefile
> @@ -41,6 +41,8 @@ include ../lib.mk
>  kdbus-test: $(OBJS)
>  	$(CC) $(CFLAGS) $^ $(LDLIBS) -o $@
>  
> +TEST_PROGS := kdbus-test
> +
>  run_tests:
>  	./kdbus-test --tap
>  
> 

Please hang on to this for a bit until kdbus makes it in.
For now I can't apply this one.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh at osg.samsung.com | (970) 217-8978
