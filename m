From: davem@davemloft.net (David Miller)
Date: Tue, 21 Jul 2015 22:20:12 -0700 (PDT)
Subject: [PATCH V2 net 0/3] BPF JIT fixes for ARM
In-Reply-To: <1437480854-22684-1-git-send-email-nschichan@freebox.fr>
References: <1437480854-22684-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20150721.222012.857420707584092557.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Schichan <nschichan@freebox.fr>
Date: Tue, 21 Jul 2015 14:14:11 +0200

> These patches are fixing bugs in the ARM JIT and should probably find
> their way to a stable kernel. All 60 test_bpf tests in Linux 4.1 release
> are now passing OK (was 54 out of 60 before).

Series applied, thanks.
