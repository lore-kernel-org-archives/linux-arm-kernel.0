From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 29 Nov 2017 09:39:05 -0800
Subject: [PATCH V2 6/7] PCI: add device wait after slot and bus reset
In-Reply-To: <1511763628-11856-7-git-send-email-okaya@codeaurora.org>
References: <1511763628-11856-1-git-send-email-okaya@codeaurora.org>
 <1511763628-11856-7-git-send-email-okaya@codeaurora.org>
Message-ID: <20171129173905.GG27742@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 01:20:27AM -0500, Sinan Kaya wrote:
> Rev 3.1 Sec 2.3.1 Request Handling Rules indicates that a device can issue
> CRS following secondary bus reset. Handle device presence gracefully.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
