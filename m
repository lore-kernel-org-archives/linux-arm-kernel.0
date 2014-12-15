From: ykk@rock-chips.com (Kuankuan.Yang)
Date: Mon, 15 Dec 2014 17:46:35 +0800
Subject: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
In-Reply-To: <548EA3B9.5080407@metafoo.de>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
 <1418612114-19692-1-git-send-email-ykk@rock-chips.com>
 <548EA3B9.5080407@metafoo.de>
Message-ID: <548EADFB.6020903@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi lars:

thks for your review, I will move it to hdmi audio driver, give the 
codec_name & codec_dai_name an const string.

Best Regards.

? 2014?12?15? 17:02, Lars-Peter Clausen ??:
> On 12/15/2014 03:55 AM, Yakir Yang wrote:
> [...]
>> +- codec-name: the dw-hdmi codec's device name
>> +- codec-dai-name: the dw-hdmi codec's dai name
>
> Please you phandles for this, the names are Linux driver and framework 
> specific details. That should not leak into the DT bindings.
>
> [..]
>
>
>
