From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 12 Aug 2013 12:45:04 -0400
Subject: [PATCH for v3.12] memory: mvebu-devbus: Remove unused variable
In-Reply-To: <1376139914-27318-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1376139914-27318-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130812164504.GL25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 10, 2013 at 10:05:14AM -0300, Ezequiel Garcia wrote:
> This variable is not being used anywhere and it's only forgotten
> garbage that should have been removed in the previous commit:
> 
>   commit 9b6e4c0a58e24c28bd757c9365824a37e80b751c
>   Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>   Date:   Fri Jul 26 10:17:38 2013 -0300
> 
>   memory: mvebu-devbus: Remove address decoding window workaround
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/memory/mvebu-devbus.c | 8 --------
>  1 file changed, 8 deletions(-)

Applied to mvebu/mbus_dt

thx,

Jason.
