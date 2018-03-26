From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Mar 2018 12:53:46 +0100
Subject: [PATCH v4 00/22] arm64: Rework cpu capabilities handling
In-Reply-To: <20180313115120.17256-1-suzuki.poulose@arm.com>
References: <20180313115120.17256-1-suzuki.poulose@arm.com>
Message-ID: <20180326115345.GA8464@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Tue, Mar 13, 2018 at 11:50:58AM +0000, Suzuki K Poulose wrote:
> This series reworks the arm64 CPU capabilities handling (which
> manages the system features and errata). The current infrastructure
> doesn't allow fine control for handling different features or errata.
> There is one rule for features and another rule for errata.

Please can you repost this based on top of for-next/core and with Dave's
acks added?

Thanks,

Will
