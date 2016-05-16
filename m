From: robh@kernel.org (Rob Herring)
Date: Mon, 16 May 2016 09:48:47 -0500
Subject: [PATCH 2/8] Documentation: regulator: tps65218: Update examples
In-Reply-To: <1462945691-904-3-git-send-email-j-keerthy@ti.com>
References: <1462945691-904-1-git-send-email-j-keerthy@ti.com>
 <1462945691-904-3-git-send-email-j-keerthy@ti.com>
Message-ID: <20160516144847.GA26659@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 11:18:05AM +0530, Keerthy wrote:
> This updates the device tree according to the preferred way of parsing
> the nodes using the regulator framework.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../devicetree/bindings/regulator/tps65218.txt     | 87 ++++++++++++++++++----
>  1 file changed, 71 insertions(+), 16 deletions(-)

It wasn't exactly clear that the compatible string "added" here is 
already used, so it looked like you were breaking compatibility at 
first. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>
