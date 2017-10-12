From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 12 Oct 2017 14:18:36 +0200
Subject: [PATCH V2 0/1] Optimise IOVA allocations for PCI devices
In-Reply-To: <c0be8925-a78d-7f9b-99c5-8a812564ce89@arm.com>
References: <1505897522-9237-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
 <cda4f03f-acf5-9b74-d8f1-774065bfc94e@semihalf.com>
 <20171012100444.GI30803@8bytes.org>
 <f7210a76-399c-3767-74d0-24a98cbf7d78@caviumnetworks.com>
 <c0be8925-a78d-7f9b-99c5-8a812564ce89@arm.com>
Message-ID: <20171012121836.6agau6cvbvtokghh@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 12, 2017 at 12:14:08PM +0100, Robin Murphy wrote:
> Yup, I've had Tomasz' patch included in my iommu/iova branch for a
> while, and the "Misc. IOVA tweaks" patches were actually written on top
> of it.
> 
> This should be the final piece of the puzzle for several arm64 server
> platforms, which exacerbate the problem by using 64K pages and having
> host bridge windows consume most of the 32-bit mem space.

Okay, thanks. Applied the patch.
