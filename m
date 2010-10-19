From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 19 Oct 2010 11:25:55 +0530
Subject: [PATCH V2 25/69] ST SPEAr: Add smi driver for serial NOR flash
In-Reply-To: <238bd0ff57f8530c597157bc07f6c46dc362e1bc.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
	<238bd0ff57f8530c597157bc07f6c46dc362e1bc.1285933331.git.viresh.kumar@st.com>
Message-ID: <4CBD32EB.5050409@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2010 05:25 PM, Viresh KUMAR wrote:
> From: Shiraz Hashim <shiraz.hashim@st.com>
> 
> SPEAr platforms(spear3xx/spear6xx/spear13xx) provide SMI(Serial Memory
> Interface) controller to access serial NOR flash. SMI provides a simple
> interface for SPI/serial NOR flashes and has certain inbuilt commands
> and features to support these flashes easily. It also makes it possible
> to map an address range in order to directly access (read/write) the SNOR
> over address bus. This patch intends to provide serial nor driver support
> for spear platforms which are accessed through SMI.
> 
> Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  arch/arm/plat-spear/include/plat/smi.h |   68 ++
>  drivers/mtd/devices/Kconfig            |    7 +
>  drivers/mtd/devices/Makefile           |    1 +
>  drivers/mtd/devices/spear_smi.c        | 1122 ++++++++++++++++++++++++++++++++
>  4 files changed, 1198 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-spear/include/plat/smi.h
>  create mode 100644 drivers/mtd/devices/spear_smi.c

David,

Any review comments on this patch??

-- 
viresh
