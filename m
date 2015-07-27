From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jul 2015 11:09:42 +0100
Subject: [PATCH v3 3/3] arm: kernel: implement cpuidle_ops with psci
 backend
In-Reply-To: <20150727100103.GE8207@red-moon>
References: <20150714122904.GV7557@n2100.arm.linux.org.uk>
 <20150714145546.GA14556@red-moon>
 <20150714204138.GW7557@n2100.arm.linux.org.uk>
 <20150715134603.GA14862@red-moon>
 <20150715144507.GZ7557@n2100.arm.linux.org.uk>
 <20150715154056.GA10418@red-moon>
 <20150726214554.GC7557@n2100.arm.linux.org.uk>
 <20150727091602.GA10308@red-moon>
 <20150727094507.GD7557@n2100.arm.linux.org.uk>
 <20150727100103.GE8207@red-moon>
Message-ID: <20150727100942.GE7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 11:01:03AM +0100, Lorenzo Pieralisi wrote:
> Mark's series consolidate ARM/ARM64 PSCI implementations, it does not
> require creating anything in arch/arm actually it moves code in arch/arm
> to drivers/firmware, consolidating it, it is definitely the right
> thing to do in this respect.
> 
> The CPUidle code comes as a second series on top of Mark's one and it
> will _not_ add anything in arch/arm (if you allow Mark to proceed), you
> have my word :)
> 
> Does it sound ok to you ?

Yes.  Please let Philippe know that there's no reason to have a phone
call over this now.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
