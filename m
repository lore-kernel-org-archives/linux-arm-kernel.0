From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Jul 2013 09:53:00 +0100
Subject: ARM Cortex A9: LL counters
In-Reply-To: <BFCB49997E59134AAAF17FFE77F8FF0667377216@REXMD.intranet.epfl.ch>
References: <BFCB49997E59134AAAF17FFE77F8FF06673738BC@REXMD.intranet.epfl.ch>
 <20130704094516.GC8782@mudshark.cambridge.arm.com>
 <BFCB49997E59134AAAF17FFE77F8FF06673759E9@REXMD.intranet.epfl.ch>
 <20130705101208.GC13063@mudshark.cambridge.arm.com>
 <BFCB49997E59134AAAF17FFE77F8FF0667377216@REXMD.intranet.epfl.ch>
Message-ID: <20130708085259.GB22057@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Mark]

On Sat, Jul 06, 2013 at 09:21:54PM +0100, Javier Picorel wrote:
> That will be perfect. Is there any way to access these memory mapped counters?

Mark was working on a PMU driver for Perf, which would expose these
counters via the perf system call. Unfortunately, the patches have rotted a
bit since then, so they would need refreshing/rebasing before they can be
reviewed.

Will
