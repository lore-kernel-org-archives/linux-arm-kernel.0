From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Jun 2017 15:17:11 +0200
Subject: clean up and modularize arch dma_mapping interface
In-Reply-To: <20170620091902.2dldmf43vhazq6yh@phenom.ffwll.local>
References: <20170608132609.32662-1-hch@lst.de>
 <20170620091902.2dldmf43vhazq6yh@phenom.ffwll.local>
Message-ID: <20170620131711.GC30769@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 11:19:02AM +0200, Daniel Vetter wrote:
> Ack for the 2 drm patches, but I can also pick them up through drm-misc if
> you prefer that (but then it'll be 4.14).

Nah, I'll plan to set up a dma-mapping tree so that we'll have common
place for dma-mapping work.
