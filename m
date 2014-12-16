From: nm@ti.com (Nishanth Menon)
Date: Tue, 16 Dec 2014 13:56:16 -0600
Subject: [PATCH 2/2] ARM: omap5/dra7xx: Fix counter frequency drift for
 AM572x errata i856.
In-Reply-To: <20141216161614.GK24110@csclub.uwaterloo.ca>
References: <cover.1418421100.git.lsorense@csclub.uwaterloo.ca>
 <358281a880ccd89873efeea75edaa6c953eac2bd.1418421100.git.lsorense@csclub.uwaterloo.ca>
 <20141214044517.GD24110@csclub.uwaterloo.ca> <549018EC.8020207@ti.com>
 <20141216161614.GK24110@csclub.uwaterloo.ca>
Message-ID: <54908E60.5080109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16/2014 10:16 AM, Lennart Sorensen wrote:
> On Tue, Dec 16, 2014 at 05:05:08PM +0530, Lokesh Vutla wrote:
>> Is this applicable for OMAP5 also?
>> If not can you drop omap5 from $subject?
> 
> DRA7xx = OMAP57xx, which to me is an omap5.  Isn't it?
*AM*57xx is not *OMAP*57xx -> there is no OMAP57xx.

AM57xx and DRA7xx are in the same generation of processors and is
derivative technology (not the same) as OMAP5432/OMAP5430.

We have been using DRA7 as a generic terminology to indicate
AM57xx/DRA7 family of processors.

-- 
Regards,
Nishanth Menon
