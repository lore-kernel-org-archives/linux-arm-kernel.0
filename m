From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 24 Nov 2009 18:40:39 +0200
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <20091124162250.GA17481@n2100.arm.linux.org.uk>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
	<c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
	<20091123172722.GE18142@n2100.arm.linux.org.uk>
	<c70ff3ad0911240746v3438bba9y556cca3f027b3dd7@mail.gmail.com>
	<20091124162250.GA17481@n2100.arm.linux.org.uk>
Message-ID: <c70ff3ad0911240840q5fd1d10cx730df18216c18bf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
this patch series fixes the cache coherency due to the speculative
prefetch issue . but what about the case were the cpu prefetches
address from I/O registers (when the cpu the manager mode)?

saeed
