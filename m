From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 11 Feb 2014 14:22:28 -0500
Subject: [PATCH 2/8] bus: mvebu-mbus: make use of
 of_find_matching_node_and_match
In-Reply-To: <1392135847-30791-3-git-send-email-joshc@codeaurora.org>
References: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
 <1392135847-30791-3-git-send-email-joshc@codeaurora.org>
Message-ID: <20140211192228.GG27395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 10:24:00AM -0600, Josh Cartwright wrote:
> Instead of the of_find_matching_node()/of_match_node() pair, which requires two
> iterations through the match table, make use of of_find_matching_node_and_match(),
> which only iterates through the table once.
> 
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> ---
>  drivers/bus/mvebu-mbus.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to mvebu/drivers

thx,

Jason.
