From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Jul 2014 11:46:51 +0200
Subject: [PATCH v10 5/7] arm: add basic support for Mediatek MT6589 boards
In-Reply-To: <1404745988-32558-6-git-send-email-matthias.bgg@gmail.com>
References: <1404745988-32558-1-git-send-email-matthias.bgg@gmail.com>
 <1404745988-32558-6-git-send-email-matthias.bgg@gmail.com>
Message-ID: <53C8ED0B.5080802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2014 05:13 PM, Matthias Brugger wrote:
> This adds a generic devicetree board file and a dtsi for boards
> based on MT6589 SoCs from Mediatek.
>
> Apart from the generic parts (gic, clocks) the only component
> currently supported are the timers.
>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> --

I will take this patchset through my tree but this patch touches an area 
I am not handling.

Olof, Arnd, do you mind to ack this patch ?

Thanks !

     -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
