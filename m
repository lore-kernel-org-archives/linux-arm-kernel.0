From: robh@kernel.org (Rob Herring)
Date: Thu, 3 Aug 2017 11:17:48 -0500
Subject: [PATCH v3 1/2] gpio: davinci: Add keystone-k2g compatible
In-Reply-To: <1501051524-5990-1-git-send-email-j-keerthy@ti.com>
References: <1501051524-5990-1-git-send-email-j-keerthy@ti.com>
Message-ID: <20170803161748.u7ier3kt3xmm25jw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 12:15:23PM +0530, Keerthy wrote:
> The patch adds keystone-k2g compatible, specific properties and
> an example.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v3:
> 
>   * Added details about family of SoCs corresponding to compatibles.
> 
>  .../devicetree/bindings/gpio/gpio-davinci.txt      | 40 +++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
