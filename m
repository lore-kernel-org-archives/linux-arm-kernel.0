From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Jan 2018 16:41:14 -0600
Subject: [PATCH v2 15/16] pwm: add documentation for pwm push-pull mode
In-Reply-To: <1515766983-15151-16-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-16-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20180119224114.qpdtnzfvewmhvdlt@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 04:23:02PM +0200, Claudiu Beznea wrote:
> Add documentation for PWM push-pull mode.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.txt |  8 +++++++-
>  Documentation/pwm.txt                         | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)

Other than squashing the previous patch into this one,

Reviewed-by: Rob Herring <robh@kernel.org>
