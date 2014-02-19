From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 19 Feb 2014 17:24:40 -0300
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <53032C14.9020502@free-electrons.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140205183457.GW8533@titan.lakedaemon.net>
 <20140217141336.GA2765@localhost> <53021BD2.3090301@free-electrons.com>
 <20140217152147.GC2765@localhost> <53022AA9.8090606@free-electrons.com>
 <20140217154421.GD2765@localhost> <530231C5.8090905@free-electrons.com>
 <20140217181902.GG2765@localhost> <53032C14.9020502@free-electrons.com>
Message-ID: <53051308.5040202@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

El 18/02/14 06:47, Gregory CLEMENT escribi?:
(snip)
> (...) what would be an acceptable
> version would be the something like the patch attached. There will be still
> an issue if old dtb is used with recent kernel, but at least the user will
> be warned.

The patch you attached is similar in spirit to what I suggested, but 
with way more warnings sprinkled around. I don't really mind either way, 
and if you prefer big warnings so be it; it's your driver after all :-)

> This code only fix the Armada 370 case, a complete solution should modify
> the dtsi for Armada XP, Armada 375, Armada 38x, Kirkwood and Dove. It should
> also make the outputname mandatory for gate-clk for consistency.

Again, all of them are your calls. Fix the issue as you see fit; as long 
as it's a technically sound I'm ok with it. But please don't reinvent 
the wheel on framework code under a principle that has no proven reason 
to be to cover up for a buggy driver.

Cheers, and have a great Wednesday :)

Emilio

PS: I'd really appreciate it if you could keep me cc'ed on respins of 
patches I comment on in the future.
