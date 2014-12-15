From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 15 Dec 2014 10:02:49 +0100
Subject: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
In-Reply-To: <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
Message-ID: <548EA3B9.5080407@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2014 03:55 AM, Yakir Yang wrote:
[...]
> +- codec-name: the dw-hdmi codec's device name
> +- codec-dai-name: the dw-hdmi codec's dai name

Please you phandles for this, the names are Linux driver and framework 
specific details. That should not leak into the DT bindings.

[..]
