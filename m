From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Oct 2014 22:25:13 +0100
Subject: RCU bug with v3.17-rc3 ?
In-Reply-To: <20141015212310.GP12379@n2100.arm.linux.org.uk>
References: <20141009204101.GA25955@debian> <20141009204637.GE25729@saruman>
 <20141009210715.GH25729@saruman> <20141010135743.GB31348@saruman>
 <20141010162531.GL12379@n2100.arm.linux.org.uk>
 <54388B81.5020306@mentor.com>
 <063D6719AE5E284EB5DD2968C1650D6D174C996E@AcuExch.aculab.com>
 <20141013114307.GO12379@n2100.arm.linux.org.uk>
 <20141014020640.GB25433@kroah.com>
 <20141015212310.GP12379@n2100.arm.linux.org.uk>
Message-ID: <20141015212513.GA3247@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 10:23:10PM +0100, Russell King - ARM Linux wrote:
> As I said, I have a patch in progress, but it seems that there needed
> to be some discussion about exactly which compiler versions are affected.
> It seems that it's not as trivial as looking at the GCC bug entry.

... and in any case, it has been a known bug for well over a year now,
and it seems that it doesn't affect _that_ many people.  So taking some
extra time to get it properly correct is the _right_ thing to do.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
