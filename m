From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Oct 2014 22:23:10 +0100
Subject: RCU bug with v3.17-rc3 ?
In-Reply-To: <20141014020640.GB25433@kroah.com>
References: <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian>
 <20141009204637.GE25729@saruman> <20141009210715.GH25729@saruman>
 <20141010135743.GB31348@saruman>
 <20141010162531.GL12379@n2100.arm.linux.org.uk> <54388B81.5020306@mentor.com>
 <063D6719AE5E284EB5DD2968C1650D6D174C996E@AcuExch.aculab.com>
 <20141013114307.GO12379@n2100.arm.linux.org.uk>
 <20141014020640.GB25433@kroah.com>
Message-ID: <20141015212310.GP12379@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 04:06:40AM +0200, Greg KH wrote:
> On Mon, Oct 13, 2014 at 12:43:07PM +0100, Russell King - ARM Linux wrote:
> > I think the only viable solution here is that:
> > 
> > 1. We blacklist the bad compiler versions outright in the kernel.
> 
> Yes, please do this, it's what we have done for other buggy compiler
> versions, no need to do something different here.
> 
> > Remember, it's the distro's choice to fix these buggy compilers, so the
> > onus is on _them_ to deal with the mess they've created by doing so.
> 
> I totally agree.
> 
> Is someone going to send this patch, or do I have to write it myself?

As I said, I have a patch in progress, but it seems that there needed
to be some discussion about exactly which compiler versions are affected.
It seems that it's not as trivial as looking at the GCC bug entry.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
