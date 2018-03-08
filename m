From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 8 Mar 2018 13:55:55 +0000
Subject: [PATCH v3 21/22] arm64: Delay enabling hardware DBM feature
In-Reply-To: <20180308135312.GQ32331@e103592.cambridge.arm.com>
References: <20180209175513.17100-1-suzuki.poulose@arm.com>
 <20180209175513.17100-43-suzuki.poulose@arm.com>
 <20180209185840.GJ5862@e103592.cambridge.arm.com>
 <e8b40320-10d2-6117-ef7f-7bbb46823ffb@arm.com>
 <20180308135312.GQ32331@e103592.cambridge.arm.com>
Message-ID: <20180308135555.yg6wdrarlpmedmmb@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 01:53:13PM +0000, Dave Martin wrote:
> In practice, we don't race booting of two CPUs against each other
> IIUC.

Yup. Today, hotplugs are strictly serialized.

Several things would have to change for parallel hotplug to be feasible.

Thanks,
Mark.
