From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Jul 2014 16:55:19 +0100
Subject: [PATCHv4 0/5] arm64: handle heterogeneous system register values
In-Reply-To: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
References: <1405524767-30220-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20140716155518.GQ29414@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 04:32:42PM +0100, Mark Rutland wrote:
> Currently the arm64 kernel assumes CPUs are homogeneous, which is a source of
> several potential problems as this is not always true. This series is an
> attempt to ameliorate the situation. The first posting [1] was titled as
> "arm64: extend/fix /proc/cpuinfo + runtime sanity checks", but with the
> addition of the I-cache policy fix this title was either going to become
> unwieldy or misleading.

For 1-4:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
