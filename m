From: jhugo@codeaurora.org (Jeffrey Hugo)
Date: Mon, 4 Jun 2018 08:58:14 -0600
Subject: [PATCH 1/5] arm64: topology: refactor reset_cpu_topology to add
 support for removing topology
In-Reply-To: <1528108797-13743-2-git-send-email-sudeep.holla@arm.com>
References: <1528108797-13743-1-git-send-email-sudeep.holla@arm.com>
 <1528108797-13743-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <9f76f11f-d77b-ae39-f06b-97ab1b981e31@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/4/2018 4:39 AM, Sudeep Holla wrote:
> Currently reset_cpu_topology clears all the CPU topology information
> and resets to default values. However we may need to just clear the
> information when we hotplig out the CPU. In preparation to add the

hotplug

> support the same, let's refactor reset_cpu_topology to clear out the
> information and reset them only if explicitly requested.
> 



-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
