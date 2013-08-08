From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Aug 2013 22:50:34 +0100
Subject: Kexec: BE kernel on ARM VE TC2
In-Reply-To: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
References: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
Message-ID: <20130808215034.GE19383@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 01:12:17PM +0100, Vijay Kilari wrote:
> Hi Will,
> 
> I am trying to make kexec work on BE kernel on ARM VE TC2.
> 
> First, to make KEXEC work with SMP on ARM VE TC2 board,
> I set nr_cpus=2 (i.e boot only A15's) this works with LE kernel.

Interesting, is this with a mainline kernel? I don't see how SMP kexec can
work on TC2 without additional patches to park the secondary cores safely.

Will
