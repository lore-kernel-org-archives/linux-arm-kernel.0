From: davem@davemloft.net (David Miller)
Date: Mon, 20 Jul 2015 20:35:05 -0700 (PDT)
Subject: [PATCH 0/6] BPF JIT fixes and features for ARM
In-Reply-To: <1437065195-10887-1-git-send-email-nschichan@freebox.fr>
References: <1437065195-10887-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20150720.203505.673166237258951387.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Schichan <nschichan@freebox.fr>
Date: Thu, 16 Jul 2015 18:46:29 +0200

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
> 
> Like previous ARM JIT patches this should go via the net tree.

You've submitted this in a manner which is very mixed up and difficult
for me to handle.

For the bug fixes, create a separate series that targets the 'net' tree.

Next, create another series with the new features that target 'net-next'.
Carefully and clearly indicate that the series depends upon the bug fix
one and I'll sort it out.

Thanks.
