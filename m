From: horms@verge.net.au (Simon Horman)
Date: Tue, 30 Oct 2012 15:14:33 +0800
Subject: [PATCH 1/4] ARM: shmobile: Remove G3EVM machine support
In-Reply-To: <1351490760-2394-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1351490760-2394-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <20121030071432.GC12329@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 03:05:57PM +0900, Nobuhiro Iwamatsu wrote:
> This machine is using old CPU of shmobile (SH7367) and cannot obtain
> machine, either.
> Therefore, remove G3EVM support.

Thanks. I will apply this to the boards branch of my renesas tree.
