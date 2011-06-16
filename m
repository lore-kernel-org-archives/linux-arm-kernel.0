From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Thu, 16 Jun 2011 10:55:47 +0200
Subject: [RFC] Add Arm cpu topology definition
In-Reply-To: <BANLkTinRGRUxKB=C_2Y2F93czWScEUo+Jw@mail.gmail.com>
References: <BANLkTinRGRUxKB=C_2Y2F93czWScEUo+Jw@mail.gmail.com>
Message-ID: <20110616085547.GH4935@const.famille.thibault.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Vincent Guittot, le Thu 16 Jun 2011 10:49:13 +0200, a ?crit :
> The affinity between Arm processors is defined in the MPIDR register.
> We can identify which processors are in the same cluster,
> and which ones have performance interdependency. The cpu topology
>  of an Arm platform can be set thanks to this register and this topology
> is then used by sched_mc and sched_smt.

Cool!  Could you check that the hwloc tool gets also gets this
information from userland through /sys, and/or send me the output of the
hwloc-gather-topology tool from hwloc so we can add an testcase for
this?

Samuel
