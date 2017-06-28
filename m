From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Jun 2017 11:48:32 -0500
Subject: [PATCH v3 2/9] dt-bindings: serial/rs485: make rs485-rts-delay
 optional
In-Reply-To: <20170626090803.10981-3-u.kleine-koenig@pengutronix.de>
References: <20170626090803.10981-1-u.kleine-koenig@pengutronix.de>
 <20170626090803.10981-3-u.kleine-koenig@pengutronix.de>
Message-ID: <20170628164832.fm3z2emonsa4teiz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 26, 2017 at 11:07:56AM +0200, Uwe Kleine-K?nig wrote:
> There are a few device trees that specify one of the already optional
> properties without also having the up to now required property
> rs485-rts-delay. Additionally there is no technical reason to require
> rs485-rts-delay and that's also what most drivers implement.
> 
> So give existing users and implementers a blessing and document
> rs485-rts-delay as optional.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/serial/rs485.txt | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
