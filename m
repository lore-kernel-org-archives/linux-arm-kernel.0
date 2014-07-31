From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 31 Jul 2014 18:54:11 +0200
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <20140731161331.GD3952@lukather>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
 <53DA3A48.8070900@metafoo.de> <20140731161331.GD3952@lukather>
Message-ID: <53DA74B3.6060502@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2014 06:13 PM, Maxime Ripard wrote:
[...]
>  From what you're saying, and judging from the drivers that already
> implement it, can't it be moved directly to the framework itself ?
>

What exactly do you mean by moving it directly to the framework? The 
slave_caps API is part of the DMAengine framework.

- Lars
