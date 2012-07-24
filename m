From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jul 2012 17:02:22 +0100
Subject: PL192 VIC Support
Message-ID: <20120724160221.GJ16435@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

I notice that in a number of the picoxcell-pc*.dtsi files there is mention
of a PL192 VIC (the "arm,pl192-vic" binding).

Does the picoxcell platform actually have a PL192, or is it a PL190? I ask
because it doesn't look like the VIC driver in mainline supports the PL192
and I wondered if you had any patches.

Cheers,

Will
