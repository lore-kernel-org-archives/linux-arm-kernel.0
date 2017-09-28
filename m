From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 28 Sep 2017 11:47:26 +0100
Subject: [RESEND][PATCH 0/4] firmware: of: populate /firmware/ node during
 init
In-Reply-To: <1506595471-10418-1-git-send-email-sudeep.holla@arm.com>
References: <1506595471-10418-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <405d07ca-481a-724f-a579-0044ee359933@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/09/17 11:44, Sudeep Holla wrote:
> Hi Rob, Arnd,
> 
> There's a push to place all firmware related device node under
> /firmware/ node. However all the associated drivers are dealing with
> device creation in their own ways. For example, qcom_scm, optee and
> meson-sm drivers deal with the node in their own way. The SCMI drivers
> I am about to add also needs to do the same. This small series is to
> make it generic so that all the users of /firmware/ node need not
> repeat the same.
> 
> There was concern that /firmware in DT is fit for /sys/firmware in sysfs.
> IMO anything exposed to userspace from such firmware interface must
> be in "/sys/firmware", but I don't see any issue with kernel handling
> them as platform device/driver internally.
> 

Please ignore this, something went wrong and patches were not delivered,
have reposted it separately.

-- 
Regards,
Sudeep
