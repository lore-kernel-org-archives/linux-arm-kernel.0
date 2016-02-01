From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 08:39:15 -0600
Subject: [PATCH 1/3] Input: tps6507x-ts - add binding for tps6507x-ts
In-Reply-To: <1454308130-12452-2-git-send-email-sushaanth.s@ti.com>
References: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
 <1454308130-12452-2-git-send-email-sushaanth.s@ti.com>
Message-ID: <20160201143915.GA9909@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 11:58:47AM +0530, Sushaanth Srirangapathi wrote:
> add binding information for tps6507x touchscreen input.
> 
> "ti,min-pressure" was added as TI specific binding because it
> was specific to tps6507x IP and not applicable or relevant for
> other touchscreen drivers.
> 
> Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
> ---
>  Documentation/devicetree/bindings/mfd/tps6507x.txt |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Seems like you would need other properties from the common touchscreen 
binding.

Acked-by: Rob Herring <robh@kernel.org>
