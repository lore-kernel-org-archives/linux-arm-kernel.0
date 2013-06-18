From: b-cousson@ti.com (Cousson, Benoit)
Date: Tue, 18 Jun 2013 11:42:17 +0200
Subject: [PATCH 0/2] ARM: AM33XX: clock: Add debugSS data to clk and hwmod
 database
In-Reply-To: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
References: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
Message-ID: <51C02B79.9010306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaihbav,

On 6/18/2013 7:07 AM, Vaibhav Hiremath wrote:
> This patch adds DebugSS data to clock-tree and hwmod data files.
>
> Changes from RFC/V1 (No code change):
> 	- Based on comments, we have to follow DT and loadable module
> 	  approach for debugSS module as well, so separated out 2 patches
> 	  of clock-tree and hwmod data addition from the RFC patch-series.
> 	- Added Paul's Ack on clock-tree patch.
> 	- Rebased on top of Benoit's for-3.11/dts branch.

Thanks for the update. I'll apply the series in my branch before sending 
the pull request to Tony.

Regards,
Benoit
