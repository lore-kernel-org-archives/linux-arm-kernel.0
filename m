From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Oct 2013 12:24:36 -0400
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131008162436.GM5402@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 06:03:29PM -0300, Ezequiel Garcia wrote:
> These clocks should never be gated, since the ethernet interfaces forget
> the assigned MAC address assigned if their clock source is turned off.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Cc: Mike Turquette <mturquette@linaro.org>
> 
>  drivers/clk/mvebu/kirkwood.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

fyi - I've dropped this and #4 favor of Sebastian's series covering the
same issue.

thx,

Jason.
