From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Tue, 16 Dec 2014 14:58:17 -0500
Subject: [PATCH 2/2] ARM: omap5/dra7xx: Fix counter frequency drift for
 AM572x errata i856.
In-Reply-To: <54908E60.5080109@ti.com>
References: <cover.1418421100.git.lsorense@csclub.uwaterloo.ca>
 <358281a880ccd89873efeea75edaa6c953eac2bd.1418421100.git.lsorense@csclub.uwaterloo.ca>
 <20141214044517.GD24110@csclub.uwaterloo.ca>
 <549018EC.8020207@ti.com>
 <20141216161614.GK24110@csclub.uwaterloo.ca>
 <54908E60.5080109@ti.com>
Message-ID: <20141216195817.GO24110@csclub.uwaterloo.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 01:56:16PM -0600, Nishanth Menon wrote:
> *AM*57xx is not *OMAP*57xx -> there is no OMAP57xx.

Oh OK.  Thanks for clearing that up.

> AM57xx and DRA7xx are in the same generation of processors and is
> derivative technology (not the same) as OMAP5432/OMAP5430.
> 
> We have been using DRA7 as a generic terminology to indicate
> AM57xx/DRA7 family of processors.

I will drop omap5 from the subject for the next version then since it
seems clear that the omap5 does not have this problem.

-- 
Len Sorensen
