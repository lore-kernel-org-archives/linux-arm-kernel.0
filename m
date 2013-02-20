From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 21:16:04 +0530
Subject: [PATCH 7/8] ARM: OMAP: hwmod: extract module address space from
 DT blob
In-Reply-To: <20130220154258.GI16652@arwen.pp.htv.fi>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
 <1361374735-22018-8-git-send-email-santosh.shilimkar@ti.com>
 <20130220154258.GI16652@arwen.pp.htv.fi>
Message-ID: <5124EFBC.1010806@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 February 2013 09:12 PM, Felipe Balbi wrote:
> Hi,
>
> On Wed, Feb 20, 2013 at 09:08:54PM +0530, Santosh Shilimkar wrote:
>> Patch adds the code for extracting the module ocp address space from device
>> tree blob in case the hwmod address space look up fails.
>
> IMHO you should lookup on DT first and if that fails try hwmod ;-)
>
I thought about that one. Since we have more devices rely on hwmod than
DT, I put the code that way. Eventually, we will need only the dt
version.

Regards,
Santosh
