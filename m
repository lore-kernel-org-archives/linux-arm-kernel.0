From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Jul 2013 11:12:09 +0100
Subject: ARM Cortex A9: LL counters
In-Reply-To: <BFCB49997E59134AAAF17FFE77F8FF06673759E9@REXMD.intranet.epfl.ch>
References: <BFCB49997E59134AAAF17FFE77F8FF06673738BC@REXMD.intranet.epfl.ch>
 <20130704094516.GC8782@mudshark.cambridge.arm.com>
 <BFCB49997E59134AAAF17FFE77F8FF06673759E9@REXMD.intranet.epfl.ch>
Message-ID: <20130705101208.GC13063@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 12:44:58AM +0100, Javier Picorel wrote:
> Thanks for the clarification! However, correct me if I'm wrong but, doesn't this mean that the "CO_LF_MISS" counter refers to L2 accesses? Thanks!

It will certainly account for some of them, but I wouldn't be surprised if
you can generate L2 accesses in ways other than missing at coherent L1.

You could look at the L2 counters and compare.

Will
