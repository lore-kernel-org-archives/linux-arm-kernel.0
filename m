From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Feb 2014 17:41:05 +0100
Subject: [PATCH 4/8] ARM: mvebu: make use of
 of_find_matching_node_and_match
In-Reply-To: <1392135847-30791-5-git-send-email-joshc@codeaurora.org>
References: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
 <1392135847-30791-5-git-send-email-joshc@codeaurora.org>
Message-ID: <20140211174105.7a2ad23b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Josh Cartwright,

On Tue, 11 Feb 2014 10:24:02 -0600, Josh Cartwright wrote:
> Instead of the of_find_matching_node()/of_match_node() pair, which requires two
> iterations through the match table, make use of of_find_matching_node_and_match(),
> which only iterates through the table once.
> 
> While we're here, mark the of_system_controller table const.
> 
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> ---
>  arch/arm/mach-mvebu/system-controller.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
