From: horms@verge.net.au (Simon Horman)
Date: Thu, 3 Oct 2013 13:11:05 +0900
Subject: [PATCH 02/03] ARM: shmobile: r7s72100 SCIF support
In-Reply-To: <20130918201120.6319.59533.sendpatchset@w520>
References: <20130918201101.6319.97667.sendpatchset@w520>
 <20130918201120.6319.59533.sendpatchset@w520>
Message-ID: <20131003041104.GD7925@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 19, 2013 at 05:11:20AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add SCIF serial port support to the r7s72100 SoC by
> adding platform devices for SCIF0 -> SCIF7 together with
> clock bindings. DT device description is excluded at
> this point since such bindings are still under
> development.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up in the soc3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.
