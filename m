From: ast@plumgrid.com (Alexei Starovoitov)
Date: Thu, 16 Jul 2015 10:35:34 -0700
Subject: [PATCH 0/6] BPF JIT fixes and features for ARM
In-Reply-To: <1437065195-10887-1-git-send-email-nschichan@freebox.fr>
References: <1437065195-10887-1-git-send-email-nschichan@freebox.fr>
Message-ID: <55A7EB66.7030700@plumgrid.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/16/15 9:46 AM, Nicolas Schichan wrote:
> This serie fixes issues with the ARM BPF JIT and adds support for more
> instructions to the ARM BPF JIT.
>
> The first three patches are fixing bugs in the ARM JIT and should
> probably find their way to a stable kernel.
>
> The last three patches add support to the ARM JIT for more BPF
> instructions, namely skb netdevice type retrieval, skb payload offset
> retrieval, and skb packet type retrieval.
>
> With the first three patches, all 60 test_bpf tests in Linux 4.1 release
> are now passing OK (was 54 out of 60 before).
>
> The last three patches allow 35 tests to use the JIT instead of 29
> before.

looks good to me.
For the series:
Acked-by: Alexei Starovoitov <ast@plumgrid.com>

you might want to try the latest 4.2-rc, since it has 238 tests :)
