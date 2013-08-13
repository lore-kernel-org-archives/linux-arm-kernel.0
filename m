From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 13 Aug 2013 18:52:38 -0400 (EDT)
Subject: Kexec: BE kernel on ARM VE TC2
In-Reply-To: <20130808215034.GE19383@mudshark.cambridge.arm.com>
References: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
 <20130808215034.GE19383@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.03.1308131851300.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Aug 2013, Will Deacon wrote:

> On Mon, Aug 05, 2013 at 01:12:17PM +0100, Vijay Kilari wrote:
> > Hi Will,
> > 
> > I am trying to make kexec work on BE kernel on ARM VE TC2.
> > 
> > First, to make KEXEC work with SMP on ARM VE TC2 board,
> > I set nr_cpus=2 (i.e boot only A15's) this works with LE kernel.
> 
> Interesting, is this with a mainline kernel? I don't see how SMP kexec can
> work on TC2 without additional patches to park the secondary cores safely.

BTW those patches are available in linux-next at the moment.


Nicolas
