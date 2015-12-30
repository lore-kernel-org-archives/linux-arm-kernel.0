From: robh@kernel.org (Rob Herring)
Date: Wed, 30 Dec 2015 10:30:31 -0600
Subject: [PATCH 2/3] wlcore/wl12xx: spi: add device tree support
In-Reply-To: <1450859744-9948-3-git-send-email-uri.mashiach@compulab.co.il>
References: <1450859744-9948-1-git-send-email-uri.mashiach@compulab.co.il>
 <1450859744-9948-3-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <20151230163031.GA24863@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 23, 2015 at 10:35:43AM +0200, Uri Mashiach wrote:
> Add DT support for the wl1271 SPI WiFi.
> 
> Add documentation file for the wl1271 SPI WiFi.
> 
> Signed-off-by: Uri Mashiach <uri.mashiach@compulab.co.il>
> Acked-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  .../bindings/net/wireless/ti,wlcore,spi.txt        | 35 +++++++++++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>
