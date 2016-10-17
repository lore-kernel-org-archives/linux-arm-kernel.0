From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 17 Oct 2016 17:47:02 +0100
Subject: [PATCH 1/3] arm64/dts: Add SMMUs to Juno
In-Reply-To: <acf4f770eab43fec8c5b6e9cddb6dd0defc52138.1476706244.git.robin.murphy@arm.com>
References: <acf4f770eab43fec8c5b6e9cddb6dd0defc52138.1476706244.git.robin.murphy@arm.com>
Message-ID: <a8396d14-7f4b-692a-1ed3-bfb76add8b6e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/10/16 13:13, Robin Murphy wrote:
> Juno has seperate MMU-401 instances in front of the DMA-330, both HDLCD
> controllers, the USB host controller, the PCIe root complex, and the
> CoreSight ETR. Since there is still work to do to make all the relevant
> subsystems interact nicely with the presence of an IOMMU, add the nodes
> to aid develompent and testing but leave them disabled by default to
> avoid nasty surprises.
>
> CC: Liviu Dudau <liviu.dudau@arm.com>
> CC: Sudeep Holla <sudeep.holla@arm.com>

Applied to [1] with $subject reformatted and typos fixed

-- 
Regards,
Sudeep

[1] git.kernel.org/sudeep.holla/linux/h/juno-dt/for-next
