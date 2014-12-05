From: wangyufen@huawei.com (wangyufen)
Date: Fri, 5 Dec 2014 10:07:41 +0800
Subject: arm64:  dose arm64 support the sysfs system call?
In-Reply-To: <118663792.1vhfOdg7Rq@wuerfel>
References: <546EE946.1020905@huawei.com> <118663792.1vhfOdg7Rq@wuerfel>
Message-ID: <5481136D.4030303@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/11/21 19:10, Arnd Bergmann wrote:
> On Friday 21 November 2014 15:27:02 wangyufen wrote:
>> Hi,
>>
>> I did ltp test on arm64, the sysfs testcases failed:
>>
>>     sysfs01     0  TWARN  :  This test can only run on kernels that support the sysfs system call
>>
>> because the __NR_sysfs didn't define in aarch64
>>
>> Dose anyone know what number the sysfs system call is in aarch64?
> 
> It's disabled of course, because we don't support ancient libc
> implementations. No modern Linux port has this.
> 
> 	Arnd
> 
> 

__NR__lchown32?__NR_lstat?__NR__sysctl?__NR_vserver have similar problems.

Dose aarch64 support those system call?

 How I distinguish the ancient libc implementations.
