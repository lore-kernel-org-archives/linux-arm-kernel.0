From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 08 Aug 2013 15:43:14 +0100
Subject: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
In-Reply-To: <52012049.7060605@arm.com>
References: <52012049.7060605@arm.com>
Message-ID: <5203AE82.5080203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 06/08/13 17:11, Sudeep KarkadaNagesha wrote:
> Hi Rob,
> 
> The following changes since commit c095ba7224d8edc71dcef0d655911399a8bd4a3f:
> 
>   Linux 3.11-rc4 (2013-08-04 13:46:46 -0700)
> 
> are available in the git repository at:
> 
>   git://linux-arm.org/linux-skn.git cpu_ofnode_dt
> 
> for you to fetch changes up to d7b5133478afd9e66a338d3125bc37b9a250ef66:
> 
>   of/device: add helper to get cpu device node from logical cpu index
> (2013-08-06 16:37:15 +0100)
> 

I was not sure whom to send pull request(you or Grant).
This needs to be pulled in and present in linux-next before I can send
the updates in SoC and cpufreq which depends on this.

Regards,
Sudeep

> ----------------------------------------------------------------
> Sudeep KarkadaNagesha (4):
>    of: add support for retrieving cpu node for a given logical cpu index
>    ARM: DT/kernel: define ARM specific arch_match_cpu_phys_id
>    driver/core: cpu: initialize of_node in cpu's device struture
>    of/device: add helper to get cpu device node from logical cpu index
> 
>  arch/arm/kernel/devtree.c |  5 +++++
>  drivers/base/cpu.c        |  2 ++
>  drivers/of/base.c         | 73 ++++++++++++++++++++++++++++++
>  include/linux/cpu.h       |  1 +
>  include/linux/of.h        |  6 ++++++
>  include/linux/of_device.h | 15 +++++++++++++++
>  6 files changed, 102 insertions(+)
> 
> PS: This is DT part of the patch series reviewed and acknowledged @
> 
> v1:
> http://archive.arm.linux.org.uk/lurker/message/20130715.102201.dfb8e04e.fr.html
> v2:
> http://archive.arm.linux.org.uk/lurker/message/20130717.140609.07fa6237.fr.html
> v3:
> http://archive.arm.linux.org.uk/lurker/message/20130722.113211.b5e3bc2a.fr.html
> 
> 
> Regards,
> Sudeep
> 
