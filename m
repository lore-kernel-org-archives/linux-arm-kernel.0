From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jun 2017 15:52:25 +0200
Subject: [PATCH 0/2] Follow-up on "ARM: Fix dma_alloc_coherent() and
 friends for NOMMU"
In-Reply-To: <1498641418-3554-1-git-send-email-vladimir.murzin@arm.com>
References: <1498641418-3554-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20170628135225.GA1268@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Vlad,

these look fine to me.  I'll wait another day or two for comments
(especially if other nommu archs actually want this code), and
if nothing shows up will apply them.
