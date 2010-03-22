From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 22 Mar 2010 12:02:06 +0800
Subject: [PATCH] ARM: pxa/raumfeld: fix button name
In-Reply-To: <1268937449-5654-1-git-send-email-daniel@caiaq.de>
References: <1268937449-5654-1-git-send-email-daniel@caiaq.de>
Message-ID: <f17812d71003212102w74f9e8d7u900e1b432fa90d82@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 2:37 AM, Daniel Mack <daniel@caiaq.de> wrote:
> This fixes a warning when booting 2.6.34-rc2:
>
> [ ? 26.619814] ------------[ cut here ]------------
> [ ? 26.624604] WARNING: at fs/proc/generic.c:316 __xlate_proc_name+0xac/0xc0()
> [ ? 26.631555] name 'on/off button'
> [ ? 26.634753] Modules linked in:
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Eric Miao <eric.miao@marvell.com>
> Cc: Sven Neumann <s.neumann@raumfeld.com>
> ---

Applied to 'fix'.
