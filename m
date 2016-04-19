From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Apr 2016 14:00:05 +0100
Subject: [PATCH v4 1/5] ACPI / processor_idle: introduce
 ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE
In-Reply-To: <201604192041.pUqHza4O%fengguang.wu@intel.com>
References: <201604192041.pUqHza4O%fengguang.wu@intel.com>
Message-ID: <57162BD5.90006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 19/04/16 13:49, kbuild test robot wrote:
> Hi,
>
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on v4.6-rc4 next-20160419]
> [if your patch is applied to the wrong git tree, please drop us a note to help improving the system]
>
> url:    https://github.com/0day-ci/linux/commits/Sudeep-Holla/ACPI-processor_idle-Add-ACPI-v6-0-LPI-support/20160419-203500
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: i386-randconfig-x000-201616 (attached as .config)
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
>
> Note: the linux-review/Sudeep-Holla/ACPI-processor_idle-Add-ACPI-v6-0-LPI-support/20160419-203500 HEAD c51fc2a756d7b0dce908a4ca043d1d458c400af5 builds fine.
>        It only hurts bisectibility.
>

Thanks for the report, it's now fixed locally.
It will part of the next version.

--
Regards,
Sudeep
