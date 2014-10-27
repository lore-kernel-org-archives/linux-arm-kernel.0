From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Mon, 27 Oct 2014 09:29:47 -0500
Subject: [PATCH] arm64: amd-seattle: Adding device tree for AMD Seattle
 platform
In-Reply-To: <A1BC53C1-A78E-4B0C-879B-F6A462E58C72@suse.de>
References: <1414153221-13104-1-git-send-email-suravee.suthikulpanit@amd.com>
 <544C2D67.8000405@suse.de> <544CEC5B.4020104@suse.de>
 <A1BC53C1-A78E-4B0C-879B-F6A462E58C72@suse.de>
Message-ID: <544E56DB.7020305@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2014 9:08 AM, Alexander Graf wrote:
>>> This option doesn't exist in upstream kernels, does it? Why not just
>>> >>make it dtb-y?
>> >
>> >CONFIG_ARCH_SEATTLE is being added one hunk above.:)
> Oops:).
>
> I'm not convinced we need a config option just for the sake of compiling a device tree though.
>
>
> Alex
>

Eventually, we would add other device driver selections when 
CONFIG_ARCH_SEATTLE=y. At this point, those drivers are still not ready.

Suravee
