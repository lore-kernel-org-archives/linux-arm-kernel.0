From: horms@verge.net.au (Simon Horman)
Date: Wed, 30 Jan 2013 13:23:57 +0900
Subject: [PATCH] ARM: shmobile: armadillo800eva: set clock rates before
 timer init
In-Reply-To: <1358485325-19673-1-git-send-email-hdk@igel.co.jp>
References: <1358485325-19673-1-git-send-email-hdk@igel.co.jp>
Message-ID: <20130130042357.GL28230@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 02:02:05PM +0900, Hideki EIRAKU wrote:
> Previously clock rates were set after initialization of timer.
> Therefore the timer used the default extal1 clock rate (25MHz)
> instead of the correct rate for this board (24MHz).
> 
> Signed-off-by: Hideki EIRAKU <hdk@igel.co.jp>

Thanks, I have applied this to the boards2 branch
and will merge it into the next branch.
