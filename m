From: gengdongjiu@huawei.com (gengdongjiu)
Date: Thu, 25 Jan 2018 16:27:45 +0800
Subject: [PATCH v6 03/13] arm64: cpufeature: Detect CPU RAS Extentions
In-Reply-To: <5A67877F.5090300@arm.com>
References: <20180115193906.30053-1-james.morse@arm.com>
 <20180115193906.30053-4-james.morse@arm.com>
 <78d4374a-f75c-6860-38ab-6373ffae3eee@huawei.com> <5A663C59.6030205@arm.com>
 <2fbdd6f2-3225-1993-cae5-0bc435189d36@huawei.com> <5A67877F.5090300@arm.com>
Message-ID: <daa4f204-a089-75ed-fdf4-625d3a58f6bc@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/1/24 3:05, James Morse wrote:
>> do you mean we do not enable "CONFIG_ARM64_RAS_EXTN" in the
>> defconfig for ARM's SOC until kernel-first RAS is supported?
> I've no idea if or when we will do kernel-first, when I bring it up, its so we
> don't build a hybrid model, and we consider how we going to add kernel-first
> support if/when it comes along.
> 
> If you want it turned on in defconfig please submit a patch to do that. I
sorry, it is my mistake,
In your patch, ARM64_RAS_EXTN is already turned on by default, so no need to turn on again.

+config ARM64_RAS_EXTN
+       bool "Enable support for RAS CPU Extensions"
+       default y
+       help
+         CPUs that support the Reliability, Availability and Serviceability


> haven't because I don't know where they go!
