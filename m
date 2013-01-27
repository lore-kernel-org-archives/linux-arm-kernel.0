From: p.pisati@gmail.com (Paolo Pisati)
Date: Sun, 27 Jan 2013 15:12:54 +0100
Subject: [BUG] panda board locks up on boot
In-Reply-To: <0247700D01F14443B9209F90AD938CC52409708C@sestoex09.enea.se>
References: <1359082886.21576.199.camel@gandalf.local.home>
 <51022FD2.8090101@compulab.co.il>
 <0247700D01F14443B9209F90AD938CC52409708C@sestoex09.enea.se>
Message-ID: <20130127141254.GC5714@stinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 08:43:15AM +0000, Mats Liljegren wrote:
> Hi Steven,
> 
> Do you have CONFIG_CPU_FREQ enabled? As I posted earlier in linux-kernel forum ("Failed booting PandaBoard ES with Linux 3.8 RC4" two days ago) my PandaBoard ES hangs while booting with this option enabled. It works fine without it. I have not bisected it down to a single commit though.

glad i'm not the only one who hit this problem:

"3.8rc4+ and cpu_freq omap: hangs, oopses, etcetc"

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg83693.html

-- 
bye,
p.
