From: green@linuxhacker.ru (Oleg Drokin)
Date: Wed, 4 May 2011 00:10:56 -0400
Subject: [PATCH 3/4] omap: move detection of NAND CS to
	common-board-devices
In-Reply-To: <724FD998-C5DC-4C36-911B-52037F6D4323@linuxhacker.ru>
References: <cover.1303682352.git.mike@compulab.co.il>
	<e2d77d1e885e6878ffbc9bf9dcf0b2dbea2b5d1f.1303682352.git.mike@compulab.co.il>
	<724FD998-C5DC-4C36-911B-52037F6D4323@linuxhacker.ru>
Message-ID: <44342B2F-34C0-490C-91B8-96A9EA683F9B@linuxhacker.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, so here's a simple patch to save everyone trouble, I guess.

Though on the other hand I can imagine that perhaps including this generic common-board-devices.c
might not be desirable for people that don't use anything from that file.
Would it be a better idea to split it to a file-per-feature?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: compile-fix.diff
Type: application/octet-stream
Size: 1123 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110504/b83fcf3f/attachment.obj>
