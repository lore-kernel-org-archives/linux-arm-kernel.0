From: will.deacon@arm.com (Will Deacon)
Date: Wed, 18 Jun 2014 18:23:44 +0100
Subject: [PATCHv2 0/4] arm64: handle heterogeneous system register values
In-Reply-To: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
References: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20140618172344.GI17851@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 06:04:30PM +0100, Mark Rutland wrote:
> Currently the arm64 kernel assumes CPUs are homogeneous, which is a source of
> several potential problems as this is not always true. This series is an
> attempt to ameliorate the situation. The first posting [1] was titled as
> "arm64: extend/fix /proc/cpuinfo + runtime sanity checks", but with the
> addition of the I-cache policy fix this title was either going to become
> unwieldy or misleading.

If you address the few minor comments I had, then:

  Acked-by: Will Deacon <will.deacon@arm.com>

for the series.

Cheers,

Will
