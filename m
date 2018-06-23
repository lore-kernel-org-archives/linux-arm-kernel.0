From: daniel@iogearbox.net (Daniel Borkmann)
Date: Sat, 23 Jun 2018 11:24:20 +0200
Subject: arm64 regression bisected to "bpf: reject any prog that failed
 read-only lock"
In-Reply-To: <20180622230943.GA27737@xps13.dannf>
References: <20180622230943.GA27737@xps13.dannf>
Message-ID: <7a9317b3-b602-1faa-1734-59ea14e301be@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23/2018 01:09 AM, dann frazier wrote:
> fyi, I'm seeing a regression that I've bisected down to:
>   9facc336876f bpf: reject any prog that failed read-only lock
> 
> A snippet of the boot messages are below. I'll be out of pocket until
> Monday, so apologies in advance for delays in responding to follow-ups.

Sorry about that, fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=9262478220eac908ae6e168c3df2c453c87e2da3
