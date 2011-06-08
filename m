From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 8 Jun 2011 16:11:16 +0300
Subject: [PATCH 0/4] drivers/iommu/ relocations
In-Reply-To: <20110608130522.GC29089@parisc-linux.org>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
	<20110608130522.GC29089@parisc-linux.org>
Message-ID: <BANLkTin5JYt4=gru181N_BuvnHB7kUTUeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2011 at 4:05 PM, Matthew Wilcox <matthew@wil.cx> wrote:
> You've missed at least parisc, ia64, alpha, sparc, powerpc and sh which
> have IOMMUs.

None of these seem to call register_iommu.

> Not that they necessarily all need to be moved across in
> one patchset, but saying "all iommu drivers" is clearly false.

I've moved only the existing IOMMU API users.
