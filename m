From: robh@kernel.org (Rob Herring)
Date: Fri, 9 Dec 2016 15:38:19 -0600
Subject: [PATCH] dt: pwm: bcm2835: fix typo in clocks property name
In-Reply-To: <20161205001025.13909-1-vz@mleia.com>
References: <20161205001025.13909-1-vz@mleia.com>
Message-ID: <20161209213819.okynrznewofatbac@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 02:10:25AM +0200, Vladimir Zapolskiy wrote:
> According to the examples of BCM2835 PWM device nodes there is a typo in
> 'clocks' property name, which is a common property name on clock consumer
> side to store a phandle to an input clock.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-bcm2835.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob
