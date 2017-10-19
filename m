From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 Oct 2017 08:37:59 -0700
Subject: [PATCH] mdt: slram: use memremap() instead of ioremap()
In-Reply-To: <20171017205642.1791-1-roy.franz@cavium.com>
References: <20171017205642.1791-1-roy.franz@cavium.com>
Message-ID: <20171019153759.GA26590@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s/mdt/mtd/ in the subject?
