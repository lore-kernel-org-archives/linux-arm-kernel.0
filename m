From: rafael@kernel.org (Rafael J. Wysocki)
Date: Sun, 6 Aug 2017 13:21:08 +0200
Subject: [PATCH v3 3/5] ACPI: Introduce DMA ranges parsing
In-Reply-To: <20170806094219.GA16298@red-moon>
References: <20170803123239.11359-4-lorenzo.pieralisi@arm.com>
 <201708061311.4aEB8P1Q%fengguang.wu@intel.com>
 <20170806094219.GA16298@red-moon>
Message-ID: <CAJZ5v0hEzxzDu+5uKsPYJHJQmxaZsXjLSW1jxDA307cea1Hk6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 6, 2017 at 11:42 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Sun, Aug 06, 2017 at 01:12:55PM +0800, kbuild test robot wrote:
>> Hi Lorenzo,
>>
>> [auto build test ERROR on pm/linux-next]
>> [also build test ERROR on v4.13-rc3 next-20170804]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Lorenzo-Pieralisi/ACPICA-resource_mgr-Allow-_DMA-method-in-walk-resources/20170804-185152
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>> config: ia64-allnoconfig (attached as .config)
>> compiler: ia64-linux-gcc (GCC) 6.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=ia64
>>
>> Note: the linux-review/Lorenzo-Pieralisi/ACPICA-resource_mgr-Allow-_DMA-method-in-walk-resources/20170804-185152 HEAD 37e91dddbbeb771d4df0001f716607f1dd8719f8 builds fine.
>>       It only hurts bisectibility.
>
> Sigh, it is a silly v2->v3 rebase mistake, a change hunk that should be
> in patch 4 ended up in patch 3, series as a whole is fine but this must
> be fixed.
>
> Rafael, please let me know the best way to handle this, I think
> me sending a v4 is the simplest so that you can just update the branch.

Please send updates of patches [3/4] and [4/4] alone.

> Apologies and thanks.

No worries.
