From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 1 Dec 2017 10:51:44 -0500
Subject: [PATCH V4 3/5] device property: Introduce a common API to fetch
 device match data
In-Reply-To: <20171201091325.weepl5rtxg4zqqyd@paasikivi.fi.intel.com>
References: <1512096776-22883-1-git-send-email-okaya@codeaurora.org>
 <1512096776-22883-4-git-send-email-okaya@codeaurora.org>
 <20171201091325.weepl5rtxg4zqqyd@paasikivi.fi.intel.com>
Message-ID: <472bc344-009c-6163-e71f-d97ba856827d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/1/2017 4:13 AM, Sakari Ailus wrote:
> Most of the dev->of_node checks have been removed from property.c and
> replaced by calls to the firmware specific fwnode operations. What remains
> should probably be moved there, too (apart from dev_fwnode).
> 
> How about adding a new op for this one to struct fwnode_operations in
> include/linux/fwnode.h?

Sure, let me look. I was following the get_dma function. Bad example I guess.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
