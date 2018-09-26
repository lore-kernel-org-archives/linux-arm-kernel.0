From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Sep 2018 16:01:00 -0500
Subject: [PATCH v2 5/8] dt-bindings: display: add data-enable polarity
 property
In-Reply-To: <20180912183222.25414-6-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
 <20180912183222.25414-6-stefan@agner.ch>
Message-ID: <20180926210100.GA31471@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Sep 2018 11:32:19 -0700, Stefan Agner wrote:
> Allow to specify the data-enable polarity required by a dumb VGA
> DAC converting parallel RGB to VGA.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  .../devicetree/bindings/display/bridge/dumb-vga-dac.txt         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
