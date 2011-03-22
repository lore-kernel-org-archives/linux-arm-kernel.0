From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 22 Mar 2011 11:39:31 -0700
Subject: [PATCH] ARM: Use asm-generic/sizes.h
In-Reply-To: <00ec01cbe897$2eed7210$8cc85630$@mprc.pku.edu.cn>
References: <1300751462-1494-1-git-send-email-sboyd@codeaurora.org>
	<201103220934.50435.arnd@arndb.de>
	<20110322092113.GB17264@n2100.arm.linux.org.uk>
	<201103221110.20861.arnd@arndb.de>
	<00ec01cbe897$2eed7210$8cc85630$@mprc.pku.edu.cn>
Message-ID: <4D88ECE3.1070209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2011 06:43 AM, Guan Xuetao wrote:
> And I just complete the SZ_* definitions for 32-bit architecture,
> and remove SZ_48M for not being power-of-2 size.

Ah, I didn't notice this part. SZ_48M is actually used by ARM code so
that would need to be added to the generic header should we go with this
patch.
