From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Oct 2017 16:24:02 +0100
Subject: [PATCH v8 0/4] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <20171012141116.32475-1-ganapatrao.kulkarni@cavium.com>
References: <20171012141116.32475-1-ganapatrao.kulkarni@cavium.com>
Message-ID: <20171012152402.GC5614@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 07:41:12PM +0530, Ganapatrao Kulkarni wrote:
> Extending json/jevent framework for parsing arm64 event files.
> Adding jevents for ThunderX2 implementation defined PMU events.
> 
> v8:
>    - Rename thunderx2 directory to cavium

For the series:

Acked-by: Will Deacon <will.deacon@arm.com>

Although note that this conflicts against a queued fix from Mark[1], so
you'll need to rebase on top of that.

Will

[1] https://patchwork.kernel.org/patch/9990237/
