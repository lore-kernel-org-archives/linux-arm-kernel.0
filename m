From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 13 Dec 2017 10:09:22 +0000
Subject: [PATCH v3] arm64: v8.4: Support for new floating point
 multiplication instructions
In-Reply-To: <1513160036-41377-1-git-send-email-gengdongjiu@huawei.com>
References: <1513160036-41377-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <73019dea-3e2c-8d03-fe1a-6c54527fa401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/17 10:13, Dongjiu Geng wrote:
> ARM v8.4 extensions add new neon instructions for performing a
> multiplication of each FP16 element of one vector with the corresponding
> FP16 element of a second vector, and to add or subtract this without an
> intermediate rounding to the corresponding FP32 element in a third vector.
> 
> This patch detects this feature and let the userspace know about it via a
> HWCAP bit and MRS emulation.
> 
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Looks good to me.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
