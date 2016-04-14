From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Apr 2016 11:33:57 -0500
Subject: [PATCH v2 2/3] devicetree: leds: Introduce "panic-indicator"
 optional property
In-Reply-To: <1460570899-24642-3-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1460570899-24642-1-git-send-email-ezequiel@vanguardiasur.com.ar>
 <1460570899-24642-3-git-send-email-ezequiel@vanguardiasur.com.ar>
Message-ID: <20160414163357.GA21964@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 03:08:18PM -0300, Ezequiel Garcia wrote:
> It's desirable to specify which LEDs are to be blinked on a kernel
> panic. Therefore, introduce a devicetree boolean property to mark
> which LEDs should be treated this way, if possible.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> ---
>  Documentation/devicetree/bindings/leds/common.txt | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Rob Herring <rob@kernel.org>
