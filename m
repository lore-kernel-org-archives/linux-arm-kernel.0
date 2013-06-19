From: b-cousson@ti.com (Benoit Cousson)
Date: Tue, 18 Jun 2013 19:49:06 -0500
Subject: [PATCH 0/2] ARM: AM33XX: clock: Add debugSS data to clk and hwmod
 database
In-Reply-To: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
References: <1371532080-27714-1-git-send-email-hvaibhav@ti.com>
Message-ID: <51C10002.5040301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav,

On 06/18/2013 12:07 AM, Vaibhav Hiremath wrote:
> This patch adds DebugSS data to clock-tree and hwmod data files.
>
> Changes from RFC/V1 (No code change):
> 	- Based on comments, we have to follow DT and loadable module
> 	  approach for debugSS module as well, so separated out 2 patches
> 	  of clock-tree and hwmod data addition from the RFC patch-series.
> 	- Added Paul's Ack on clock-tree patch.
> 	- Rebased on top of Benoit's for-3.11/dts branch.
>
> Link to original RFC -
> http://archive.arm.linux.org.uk/lurker/message/20130304.113554.53c9ec25.en.html
>
> Vaibhav Hiremath (2):
>    ARM: AM33XX: clock: Add debugSS clock nodes

I'll take that one, but the next one:

>    ARM: AM33XX: hwmod: Add hwmod data for debugSS

Still need to go through Paul's tree.

Paul,

Do you want to ack it, so I'll be able to take the whole series?

Thanks,
Benoit
