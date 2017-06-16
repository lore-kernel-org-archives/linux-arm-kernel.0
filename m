From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 10:39:07 +0200
Subject: [PATCH 33/44] openrisc: remove arch-specific dma_supported
 implementation
In-Reply-To: <CAMuHMdUPeFJJtz8eJkQEAR-2w9oHt-fXeGHvvKFLfU2A4YyviQ@mail.gmail.com>
References: <20170608132609.32662-1-hch@lst.de>
 <20170608132609.32662-34-hch@lst.de>
 <CAMuHMdUPeFJJtz8eJkQEAR-2w9oHt-fXeGHvvKFLfU2A4YyviQ@mail.gmail.com>
Message-ID: <20170616083907.GB10582@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 02:20:42PM +0200, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Thu, Jun 8, 2017 at 3:25 PM, Christoph Hellwig <hch@lst.de> wrote:
> > This implementation is simply bogus - hexagon only has a simple
> 
> openrisc?

Yeah.
