From: horms@verge.net.au (Simon Horman)
Date: Wed, 10 Jul 2013 10:13:28 +0900
Subject: [PATCH 02/04] ARM: shmobile: Use pm-rmobile on sh7372 and
 r8a7740 only
In-Reply-To: <20130709104001.1891.16375.sendpatchset@w520>
References: <20130709103944.1891.67462.sendpatchset@w520>
 <20130709104001.1891.16375.sendpatchset@w520>
Message-ID: <20130710011327.GM32603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 07:40:01PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The functions in pm-rmobile.c are only used on sh7372 and
> r8a7740, so adjust the Makefile to only link in that file
> in case those SoCs are selected.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up for v3.12 in the cleanup branch.
It should appear in renesas-next-20130710
