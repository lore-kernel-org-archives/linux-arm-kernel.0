From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Aug 2018 17:27:08 -0500
Subject: [RESEND PATCH v5 5/9] pwm: add PWM modes
In-Reply-To: <1535461286-12308-6-git-send-email-claudiu.beznea@microchip.com>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-6-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20180828222708.GA22527@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 04:01:22PM +0300, Claudiu Beznea wrote:
> Add PWM normal and complementary modes.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.txt |  9 +++++++--

Acked-by: Rob Herring <robh@kernel.org>

>  Documentation/pwm.txt                         | 26 +++++++++++++++++++++++---
>  include/dt-bindings/pwm/pwm.h                 |  1 +
>  3 files changed, 31 insertions(+), 5 deletions(-)
