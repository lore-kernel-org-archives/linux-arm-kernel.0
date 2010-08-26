From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Thu, 26 Aug 2010 03:20:57 +0200
Subject: [PATCH/RFCv4 3/6] mm: cma: Added SysFS support
In-Reply-To: <20100825203707.GB5318@phenom.dumpdata.com>
References: <cover.1282286941.git.m.nazarewicz@samsung.com>
	<0b02e05fc21e70a3af39e65e628d117cd89d70a1.1282286941.git.m.nazarewicz@samsung.com>
	<343f4b0edf9b5eef598831700cb459cd428d3f2e.1282286941.git.m.nazarewicz@samsung.com>
	<9883433f103cc84e55db150806d2270200c74c6b.1282286941.git.m.nazarewicz@samsung.com>
	<20100825203707.GB5318@phenom.dumpdata.com>
Message-ID: <op.vh0t07om7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 25 Aug 2010 22:37:08 +0200, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
> Whats the rationale for having those #ifdef CONFIG_CMA_SYSFS sprinkled
> in the C code? Is SysFS not used on StrongARM? Why not implicitly include
> the SysFS support?

The SysFS CMA interface is meant for development only and because of that
I decided to separate it form the core in a separate patch and enable it
only when explicitly requested.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
