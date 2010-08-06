From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Fri, 06 Aug 2010 15:31:00 +0200
Subject: [PATCHv2 2/4] mm: cma: Contiguous Memory Allocator added
In-Reply-To: <201008030919.36575.hverkuil@xs4all.nl>
References: <cover.1280151963.git.m.nazarewicz@samsung.com>
	<201008011526.13566.hverkuil@xs4all.nl> <op.vgticdzj7p4s8u@pikus>
	<201008030919.36575.hverkuil@xs4all.nl>
Message-ID: <op.vg0qhyki7p4s8u@pikus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hans,

I've just posted updated patchset.  It changes the way regions are
reserved somehow so our discussion is not entirely applicable to a
new version I think.

I preserved the original "map" there.  I came to a conclusion that
your approach is not that different from what I had in mind but I
noticed that with your syntax it's impossible to specify the order
of regions to try. For instance that driver should first try region
"foo" and then region "bar" and not the other way around.

I'm looking forward to hearing your comments on the newest version
of CMA.

-- 
Best regards,                                        _     _
| Humble Liege of Serenely Enlightened Majesty of  o' \,=./ `o
| Computer Science,  Micha? "mina86" Nazarewicz       (o o)
+----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
