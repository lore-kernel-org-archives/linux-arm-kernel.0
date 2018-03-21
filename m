From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Mar 2018 15:07:14 +0000
Subject: [PATCH v4 11/22] arm64: capabilities: Group handling of features
 and errata workarounds
In-Reply-To: <20180313115120.17256-12-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
 <20180313115120.17256-12-suzuki.poulose@arm.com>
Message-ID: <20180321150712.GB16308@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 11:51:09AM +0000, Suzuki K Poulose wrote:
> Now that the features and errata workarounds have the same
> rules and flow, group the handling of the tables.
> 
> Cc: Dave Martin <dave.martin@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

It looks like nothing signifcant has changed since v3 [1], and I was
reasonably happy with this last time around [2], so

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

[...]

Cheers
---Dave

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/558742.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-February/558763.html
