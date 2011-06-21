From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Jun 2011 19:59:28 -0300
Subject: [PATCH] ARM: report present cpus in /proc/cpuinfo
In-Reply-To: <4E012198.6010405@nvidia.com>
References: <4E012198.6010405@nvidia.com>
Message-ID: <BANLkTi=esuxynPT74v-RisWpp_0=6F0=aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 7:56 PM, Jon Mayo <jmayo@nvidia.com> wrote:
> Because arm linux likes to dynamically hotplug cpus, the meaning of
> online has changed slightly. Previously online meant a cpus is
> schedulable, and conversely offline means they it is not schedulable.
> But with the current power management infrastructure there are cpus
> that can be scheduled (after they are woken up automatically), yet are
> not considered "online" because the masks and flags for them are not
> set.
>
> ---
> ?arch/arm/kernel/setup.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)

You missed your Signed-off-by line.

Regards,

Fabio Estevam
