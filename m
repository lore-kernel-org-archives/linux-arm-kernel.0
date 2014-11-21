From: wangyufen@huawei.com (wangyufen)
Date: Fri, 21 Nov 2014 15:27:02 +0800
Subject: arm64:  dose arm64 support the sysfs system call?
Message-ID: <546EE946.1020905@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I did ltp test on arm64, the sysfs testcases failed:

    sysfs01     0  TWARN  :  This test can only run on kernels that support the sysfs system call

because the __NR_sysfs didn't define in aarch64

Dose anyone know what number the sysfs system call is in aarch64?


Thanks,
Wang
