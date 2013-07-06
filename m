From: javier.picorel@epfl.ch (Javier Picorel)
Date: Sat, 6 Jul 2013 20:21:54 +0000
Subject: ARM Cortex A9: LL counters
In-Reply-To: <20130705101208.GC13063@mudshark.cambridge.arm.com>
References: <BFCB49997E59134AAAF17FFE77F8FF06673738BC@REXMD.intranet.epfl.ch>
 <20130704094516.GC8782@mudshark.cambridge.arm.com>
 <BFCB49997E59134AAAF17FFE77F8FF06673759E9@REXMD.intranet.epfl.ch>,
 <20130705101208.GC13063@mudshark.cambridge.arm.com>
Message-ID: <BFCB49997E59134AAAF17FFE77F8FF0667377216@REXMD.intranet.epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

That will be perfect. Is there any way to access these memory mapped counters?
________________________________________
From: Will Deacon [will.deacon at arm.com]
Sent: 05 July 2013 12:12
To: Javier Picorel
Cc: linux-arm-kernel at lists.infradead.org; Mark Rutland
Subject: Re: ARM Cortex A9: LL counters

On Fri, Jul 05, 2013 at 12:44:58AM +0100, Javier Picorel wrote:
> Thanks for the clarification! However, correct me if I'm wrong but, doesn't this mean that the "CO_LF_MISS" counter refers to L2 accesses? Thanks!

It will certainly account for some of them, but I wouldn't be surprised if
you can generate L2 accesses in ways other than missing at coherent L1.

You could look at the L2 counters and compare.

Will
