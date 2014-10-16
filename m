From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 16 Oct 2014 09:27:01 -0600
Subject: [PATCH v2 10/53] dmaengine: bcm2835: Split device_control
In-Reply-To: <1413454672-27400-11-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
 <1413454672-27400-11-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <543FE3C5.4070707@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2014 04:17 AM, Maxime Ripard wrote:
> Split the device_control callback of the Broadcom BCM2835 DMA driver to make
> use of the newly introduced callbacks, that will eventually be used to retrieve
> slave capabilities.

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
