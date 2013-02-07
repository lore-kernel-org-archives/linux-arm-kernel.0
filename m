From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 07 Feb 2013 14:44:27 +1030
Subject: [PATCH v5 00/45] CPU hotplug: stop_machine()-free CPU hotplug
In-Reply-To: <510FBC01.2030405@linux.vnet.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <510FBC01.2030405@linux.vnet.ibm.com>
Message-ID: <87haloiwv0.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:
> On 01/22/2013 01:03 PM, Srivatsa S. Bhat wrote:
>                  Avg. latency of 1 CPU offline (ms) [stop-cpu/stop-m/c latency]
>
> # online CPUs    Mainline (with stop-m/c)       This patchset (no stop-m/c)
>
>       8                 17.04                          7.73
>
>      16                 18.05                          6.44
>
>      32                 17.31                          7.39
>
>      64                 32.40                          9.28
>
>     128                 98.23                          7.35

Nice!  I wonder how the ARM guys feel with their quad-cpu systems...

Thanks!
Rusty.
