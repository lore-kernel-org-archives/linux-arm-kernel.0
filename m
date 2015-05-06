From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed, 06 May 2015 14:17:03 -0600
Subject: [PATCH v4 1/7] selftests: copy TEST_DIRS to INSTALL_PATH
In-Reply-To: <1429656588-8832-1-git-send-email-tyler.baker@linaro.org>
References: <1429656588-8832-1-git-send-email-tyler.baker@linaro.org>
Message-ID: <554A76BF.6030604@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2015 04:49 PM, Tyler Baker wrote:
> Loop over all TEST_DIRS and recursively copy them to the INSTALL_PATH. Tests
> such as ftrace require a directory and all of it's contents to execute the
> test properly, thus these directories and files need to be copied when we
> perform an install.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Tyler Baker <tyler.baker@linaro.org>

Thanks for working on this. Applied to linux-kselftest next
for 4.2

thanks,
-- Shuah


-- 
Shuah Khan
Sr. Linux Kernel Developer
Open Source Innovation Group
Samsung Research America (Silicon Valley)
shuahkh at osg.samsung.com | (970) 217-8978
