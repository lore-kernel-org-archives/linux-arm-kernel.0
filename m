From: gerald.schaefer@de.ibm.com (Gerald Schaefer)
Date: Thu, 8 Jun 2017 18:23:11 +0200
Subject: [PATCH 19/44] s390: implement ->mapping_error
In-Reply-To: <20170608132609.32662-20-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-20-hch@lst.de>
Message-ID: <20170608182311.05cced9e@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  8 Jun 2017 15:25:44 +0200
Christoph Hellwig <hch@lst.de> wrote:

> s390 can also use noop_dma_ops, and while that currently does not return
> errors it will so in the future.  Implementing the mapping_error method
> is the proper way to have per-ops error conditions.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
