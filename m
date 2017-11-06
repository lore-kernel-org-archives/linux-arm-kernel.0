From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Nov 2017 14:26:59 -0600
Subject: [PATCH 1/2] dt-bindings: rng: Document BCM7278 RNG200 compatible
In-Reply-To: <20171101232006.3943-2-f.fainelli@gmail.com>
References: <20171101232006.3943-1-f.fainelli@gmail.com>
 <20171101232006.3943-2-f.fainelli@gmail.com>
Message-ID: <20171106202659.kmqvq6jvvehsg6ii@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 04:20:05PM -0700, Florian Fainelli wrote:
> BCM7278 includes a RGN200 hardware random number generator, document the
> compatible string for that version of the IP.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/rng/brcm,iproc-rng200.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
