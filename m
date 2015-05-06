From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed, 06 May 2015 14:21:31 -0600
Subject: [PATCH v4 5/7] selftest/x86: have no dependency on all when cross
 building
In-Reply-To: <1429656705-10016-1-git-send-email-tyler.baker@linaro.org>
References: <1429656705-10016-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <554A77CB.9080802@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 04:51 PM, Tyler Baker wrote:
> If the CROSS_COMPILE is set remove all's dependency on all_32 and all_64.
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
