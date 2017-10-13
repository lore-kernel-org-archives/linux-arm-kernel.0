From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 13 Oct 2017 14:46:42 +0800
Subject: [PATCH 1/4] ARM: imx: imx31moboard: Include
 "board-mx31moboard.h" header file
In-Reply-To: <1506365759-28768-1-git-send-email-marco.franchi@nxp.com>
References: <1506365759-28768-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <20171013064640.GG8833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 03:55:56PM -0300, Marco Franchi wrote:
> The following build warnings are seen with W=1:
> 
> warning: no previous prototype for ?mx31moboard_devboard_init? 
> [-Wmissing-prototypes] void __init mx31moboard_devboard_init(void)
> warning: no previous prototype for ?mx31moboard_marxbot_init? 
> [-Wmissing-prototypes] void __init mx31moboard_marxbot_init(void)
> 
> Fix these warnings by including "board-mx31moboard.h".
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>

Applied all, thanks.
