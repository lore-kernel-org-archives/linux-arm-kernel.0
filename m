From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 09:11:38 -0800
Subject: [GIT PULL v2] Renesas ARM-based SoC for v3.9
In-Reply-To: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
References: <1359086133-23357-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130129171138.GE16188@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 12:55:18PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following soc enhancements for 3.9.
> 
> This series is based on a merge of the irqchip/gic-vic-move and
> timer/cleanup branches in the arm-soc tree. There were a number of
> conflicts in this merge, as indicated by the merge commit
> 6265b0f325eed54558b35769aecb1d79423295c7. In each case I took care to
> match the merge made in the arm-soc tree which is evident in the for-next
> branch.
> 
> ----------------------------------------------------------------
> The following changes since commit 6265b0f325eed54558b35769aecb1d79423295c7:
> 
>   Merge remote-tracking branches 'arm-soc/irqchip/gic-vic-move' and 'arm-soc/timer/cleanup' into soc (2013-01-24 17:57:20 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc
> 

Merged, thanks. You had resolved the board_bcm conflict slightly differenlty
(technically better), but to keep it common with what we have, I added back
the extra line of whitespace.

By the way, you should look into starting to use signed tags for your pull
requests, since it gives you a place to give a short description of the branch
(and that description makes it into the commit with 0 work on our behalf :)



-Olof
