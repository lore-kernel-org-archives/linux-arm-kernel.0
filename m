From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 12 Oct 2016 05:43:15 -0700
Subject: [RFC PATCH 05/11] pci: rename *host* directory to *controller*
In-Reply-To: <1473829927-20466-6-git-send-email-kishon@ti.com>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <1473829927-20466-6-git-send-email-kishon@ti.com>
Message-ID: <20161012124315.GC942@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a big and painful change.  I'd suggest to either drop it for
now or convince Bjorn to take it as a scripted renamed just after -rc1.
