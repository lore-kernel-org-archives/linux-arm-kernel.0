From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 21 May 2013 15:02:28 +0200
Subject: Patch merge request for STE Snowball build failure on
 linux-arm-soc-for-next.
In-Reply-To: <CAMGVPmWRLddtZ3fS8DWovW=X7oQzy2x_-_SU60u+x9eTGaO9+A@mail.gmail.com>
References: <CAMGVPmWRLddtZ3fS8DWovW=X7oQzy2x_-_SU60u+x9eTGaO9+A@mail.gmail.com>
Message-ID: <20130521130228.GD4589@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Botao,

On Tue, May 21, 2013 at 09:34:52PM +1000, Botao Sun wrote:
> Hi,
> 
> There is a build failure for STE Snowball on "linux-arm-soc-for-next"
> branch in Linaro Kernel CI system:
> 
> https://ci.linaro.org/jenkins/job/linux-arm-soc-for-next/hwpack=snowball,label=kernel_cloud/46/console
> 
> which is caused by:
> 
> 01:31:32
> /mnt/ci_build/workspace/linux-arm-soc-for-next/hwpack/snowball/label/kernel_cloud/drivers/mfd/ab8500-debugfs.c:95:23:
> fatal error: mach/irqs.h: No such file or directory
> 01:31:32  #include <mach/irqs.h>
> 01:31:32                        ^
> 01:31:32 compilation terminated.
> 01:31:32 make[3]: *** [drivers/mfd/ab8500-debugfs.o] Error 1
> 01:31:32 make[2]: *** [drivers/mfd] Error 2
> 01:31:32 make[1]: *** [drivers] Error 2
> 
> To solve this issue, here is the patch which Linux Walleij provided on 11
> April 2013:
> 
> https://lkml.org/lkml/2013/4/11/101
> 
> Would anyone like to merge the patch to fix this compiling error?
It is queued in mfd-fixes, and I will send a pull request for that either
tonight or tomorrow.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
