From: viresh.linux@gmail.com (viresh kumar)
Date: Tue, 12 Jun 2012 14:18:19 +0100
Subject: [PATCH v8 11/13] ARM: convert spear13xx to smp_ops
In-Reply-To: <1339504256-11266-12-git-send-email-marc.zyngier@arm.com>
References: <1339504256-11266-1-git-send-email-marc.zyngier@arm.com>
 <1339504256-11266-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAOh2x=kN2yO_xkjkHdMK9mW_f6p0E_Wu6Rq1M_pPztWeohg+Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 1:30 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Convert the spear13xx platforms to use the smp_ops to provide
> their SMP and CPU hotplug operations.
>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> ?arch/arm/mach-spear13xx/hotplug.c ? ? ? ? ? ? ?| ? ?6 +++---
> ?arch/arm/mach-spear13xx/include/mach/generic.h | ? ?7 +++++++
> ?arch/arm/mach-spear13xx/platsmp.c ? ? ? ? ? ? ?| ? 16 ++++++++++++----
> ?arch/arm/mach-spear13xx/spear1310.c ? ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-spear13xx/spear1340.c ? ? ? ? ? ?| ? ?1 +
> ?5 files changed, 24 insertions(+), 7 deletions(-)

Reviewed-by: Viresh Kumar <viresh.linux@gmail.com>
