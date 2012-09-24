From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 24 Sep 2012 17:27:03 -0500
Subject: [PATCH v2] of: dma: fix typos in generic dma binding definition
In-Reply-To: <1348066188-17937-1-git-send-email-mporter@ti.com>
References: <1348066188-17937-1-git-send-email-mporter@ti.com>
Message-ID: <5060DE37.4080001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

On 09/19/2012 09:49 AM, Matt Porter wrote:
> Some semicolons were left out in the examples.
> 
> The #dma-channels and #dma-requests properties have a prefix
> that is, by convention, reserved for cell size properties.
> Rename those properties to dma-channels and dma-requests.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>

Acked-by: Jon Hunter <jon-hunter@ti.com>

Thanks for catching and fixing these!

Cheers
Jon
