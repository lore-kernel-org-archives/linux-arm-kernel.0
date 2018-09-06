From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Sep 2018 11:04:46 +0100
Subject: [PATCH 06/21] arm64: use for_each_of_cpu_node iterator
In-Reply-To: <20180905193738.19325-7-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-7-robh@kernel.org>
Message-ID: <20180906100445.GA3592@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 02:37:23PM -0500, Rob Herring wrote:
> Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
> has the side effect of defaulting to iterating using "cpu" node names in
> preference to the deprecated (for FDT) device_type == "cpu".
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Please ack and I will take via the DT tree. This is dependent on the
> first 2 patches.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
