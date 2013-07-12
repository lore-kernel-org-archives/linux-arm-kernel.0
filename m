From: horms@verge.net.au (Simon Horman)
Date: Fri, 12 Jul 2013 13:00:05 +0900
Subject: [PATCH v2 01/02] ARM: shmobile: Introduce r8a7790_read_mode_pins()
In-Reply-To: <20130711162219.933.96902.sendpatchset@w520>
References: <20130711162209.933.47610.sendpatchset@w520>
 <20130711162219.933.96902.sendpatchset@w520>
Message-ID: <20130712040005.GB26287@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 12, 2013 at 01:22:19AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Break out the r8a7790 boot mode code into a separate
> function so it can be shared by multiple users.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks.

I have queued this up for v3.12 in the soc branch and it
is available in renesas-devel-20130712.
