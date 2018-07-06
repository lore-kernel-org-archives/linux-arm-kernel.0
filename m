From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Jul 2018 14:16:04 +0100
Subject: [PATCHv3 00/12] atomics: generate atomic headers / instrument
 arm64
In-Reply-To: <20180705164053.10073-1-mark.rutland@arm.com>
References: <20180705164053.10073-1-mark.rutland@arm.com>
Message-ID: <20180706131603.GA11172@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Thu, Jul 05, 2018 at 05:40:41PM +0100, Mark Rutland wrote:
> This series scripts the generation of the various atomic headers, to ensure
> that the various atomic APIs remain consistent, reducing the risk of human
> error, and simplifying future rework. This fleshes out the instrumented atomics
> such that arm64 can be migrated over to them.

Thanks! For the series apart from the shell scripts:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
