From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 8 Jun 2013 10:15:01 -0400
Subject: [PATCH 01/14] bus: mvebu-mbus: Use pr_fmt
In-Reply-To: <1370623671-7748-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1370623671-7748-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130608141501.GX23859@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 01:47:38PM -0300, Ezequiel Garcia wrote:
> In order to clean message printing, we replace pr_info with pr_fmt.
> This is purely cosmetic change, with the sole purpose of making
> the code a bit more readable.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/bus/mvebu-mbus.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

As Thomas mentioned, this patch has been applied to mvebu/cleanup with
his Ack.

thx,

Jason.
