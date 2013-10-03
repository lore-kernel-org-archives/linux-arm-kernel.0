From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 11:37:07 +0900
Subject: [PATCH 03/10] ARM: shmobile: r8a7791 IRQC platform device support
In-Reply-To: <20131001081219.4136.26850.sendpatchset@w520>
References: <20131001081143.4136.46925.sendpatchset@w520>
 <20131001081219.4136.26850.sendpatchset@w520>
Message-ID: <20131003023705.GB28463@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 05:12:19PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add a platform device for the r8a7791 IRQC hardware
> driving IRQ pins IRQ0 to IRQ9. The Linux interrupt
> number is statically assigned to allow board code
> written in C to make use of static interrupt numbers.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up in the soc3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.
