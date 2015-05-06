From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed, 06 May 2015 14:20:40 -0600
Subject: [PATCH v4 4/7] selftest/x86: build both bitnesses
In-Reply-To: <1429656693-9937-1-git-send-email-tyler.baker@linaro.org>
References: <1429656693-9937-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <554A7798.4070502@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 04:51 PM, Tyler Baker wrote:
> Using uname with the processor flag option in some cases can yield 'unknown'
> so lets use the machine flag option as it is deterministic. Add a dependency
> for all_32 when building on a x86 64 bit host so that both bitnesses are
> built in this case.
> 
> Cc: Andy Lutomirski <luto@amacapital.net>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>
> ---

I will wait on this patch and other x85 patches in this series
until x86 always build 32 breaking make kselftest target.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh at osg.samsung.com | (970) 217-8978
