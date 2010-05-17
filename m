From: notasas@gmail.com (Grazvydas Ignotas)
Date: Mon, 17 May 2010 12:38:55 +0300
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100514101615.GF10339@n2100.arm.linux.org.uk>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<20100505150209.GC2606@n2100.arm.linux.org.uk>
	<20100513174023.GB13001@n2100.arm.linux.org.uk>
	<20100513211951.GH3428@atomide.com>
	<20100513215825.GC13001@n2100.arm.linux.org.uk>
	<20100513220139.GO3428@atomide.com>
	<20100513221229.GD13001@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C54F0247@dbde02.ent.ti.com>
	<AANLkTikZvfvjY9e2QNWRwVcJcTvn58Ly_DgzrcXKu2iJ@mail.gmail.com>
	<20100514101615.GF10339@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinY9M2cHKw86hTLaMUCvBX57o8AioBtrENB-JhK@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 1:16 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>> because it also uses reserve_bootmem() in
>> drivers/video/omap2/vram.c and later ioremap on RAM. Perhaps LMB can
>> be used to fix that too?
>
> WTF is reserve_bootmem doing in a driver?

IIRC Tony refused any new fb related code in arch/arm/*omap* so it
ended up there (or maybe because of something else, not that I had
anything to do with this).
