From: hch@lst.de (Christoph Hellwig)
Date: Sun, 26 Jul 2015 19:31:41 +0200
Subject: [PATCH v2 24/25] arch: remove ioremap_wt, replace with
 arch_memremap
In-Reply-To: <20150725024015.8664.42950.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725024015.8664.42950.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150726173141.GC29513@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation/x86/pat.txt needs to be updated for this change as well.
