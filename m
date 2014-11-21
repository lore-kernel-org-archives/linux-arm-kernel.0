From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Fri, 21 Nov 2014 09:19:30 -0800
Subject: [GIT PULL 2/3] ARM: keystone: config updates for 3.19
In-Reply-To: <201411201314.49184.arnd@arndb.de>
References: <1415843982-5739-1-git-send-email-ssantosh@kernel.org>
 <1415843982-5739-2-git-send-email-ssantosh@kernel.org>
 <201411201314.49184.arnd@arndb.de>
Message-ID: <546F7422.5070707@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2014 4:14 AM, Arnd Bergmann wrote:
> On Thursday 13 November 2014, Santosh Shilimkar wrote:
>> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
>>
>>    Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
>>
>> are available in the git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc
>>
>> for you to fetch changes up to 97ef1af9b275924406556bfaec528a3e9e2980c7:
>>
>>    ARM: keystone: defconfig: add options to enable PCI controller (2014-11-04 10:29:39 -0800)
>>
>> ----------------------------------------------------------------
>> Keystone config updates for 3.19
>>
>>          - Enable PCIE controller and related options
>>          - Enable MDIO and ethernet phy options
>>          - Enable DSP IRQCHIP option
>
> Pulled into next/defconfig.
>
Thanks Arnd !!

> Can you send an update so we also enable all of this in multi_v7_defconfig?
>
Yep. I am planning to sync up the multi_v7_defconfig since there are
quite a few new options have been enabled after my last sync up.

Will do that after this merge window.

Regards,
Santosh
