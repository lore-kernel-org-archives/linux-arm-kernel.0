From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Jul 2016 17:13:46 -0500
Subject: [PATCH 1/4] Documentation: dt: iio: at91_adc: fix trigger node
 names
In-Reply-To: <1468364850-32475-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468364850-32475-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160716221346.GA7057@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 01:07:27AM +0200, Alexandre Belloni wrote:
> The trigger doesn't need the reg property. When it is not defined, the node
> name doesn't need a unit-address. Remove them from the example.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/at91_adc.txt | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
