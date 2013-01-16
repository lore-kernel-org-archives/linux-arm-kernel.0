From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Jan 2013 11:25:56 +0000
Subject: [PATCH 05/14] lib: Add I/O map cache implementation
In-Reply-To: <20130116101822.GA17706@avionic-0098.adnet.avionic-design.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <20130109231758.GA27065@obsidianresearch.com>
 <20130110071937.GG15212@avionic-0098.adnet.avionic-design.de>
 <201301100917.19577.arnd@arndb.de>
 <20130110102544.GA5546@avionic-0098.adnet.avionic-design.de>
 <20130110182007.GA28004@obsidianresearch.com>
 <20130110185505.GA22944@avionic-0098.adnet.avionic-design.de>
 <20130110190327.GA23110@avionic-0098.adnet.avionic-design.de>
 <20130110192417.GA18478@obsidianresearch.com>
 <20130116101822.GA17706@avionic-0098.adnet.avionic-design.de>
Message-ID: <20130116112556.GR23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 11:18:22AM +0100, Thierry Reding wrote:
> 		err = ioremap_page_range(virt, virt + SZ_64K - 1, phys,

Why -1 here?
