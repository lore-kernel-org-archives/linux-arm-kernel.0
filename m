From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 7 Feb 2018 14:47:12 +0000
Subject: [PATCH v2 02/20] arm64: capabilities: Move errata work around
 check on boot CPU
In-Reply-To: <20180207103737.GS5862@e103592.cambridge.arm.com>
References: <20180131182807.32134-1-suzuki.poulose@arm.com>
 <20180131182807.32134-3-suzuki.poulose@arm.com>
 <20180207103737.GS5862@e103592.cambridge.arm.com>
Message-ID: <9e21e22a-b41c-ced0-48aa-6738f3b062d9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/02/18 10:37, Dave Martin wrote:
> On Wed, Jan 31, 2018 at 06:27:49PM +0000, Suzuki K Poulose wrote:
>> We trigger CPU errata work around check on the boot CPU from
>> smp_prepare_boot_cpu() to make sure that we run the checks only
>> after the CPU feature infrastructure is initialised. While this
>> is correct, we can also do this from init_cpu_features() which
>> initilisation of the infrastructure, and is called only on the
> 
> Typo or missing words here?
> 
> Should this be "which initialises the infrastructure" or "which is
> called to initialise the infrastructure"?
> 
> With that (or any suitable rewording):

Correct. Will fix it.

> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thanks
Suzuki
