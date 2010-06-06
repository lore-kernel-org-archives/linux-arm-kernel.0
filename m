From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 6 Jun 2010 17:27:58 +0800
Subject: [PATCHv2 1/3] MTD/pxa: use __devinit for pxa2xx_flash_probe
In-Reply-To: <4C0A86D9.2070106@mvista.com>
References: <4C0A13BA.6050700@gmail.com> <4C0A86D9.2070106@mvista.com>
Message-ID: <AANLkTinRQ2TwU0fj2k70GdNFKmOVQ4DLc2xELu7HnnZ5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 6, 2010 at 1:18 AM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> Wan ZongShun wrote:
>
>> This patch is to use the '__devinit' for pxa2xx_flash_probe.
>
> ? Why? Is it hot-pluggable device? I guess not...
>

Then I guess the __devexit is not applicable to pxa2xx_flash_remove as well.
Apart from the _probe() being unnecessarily built in when HOTPLUG is
defined, is there any drawbacks. It does make code a little bit consistent
from my POV.

>> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
>> Acked-by: Eric Miao <eric.y.miao@gmail.com>
>
> WBR, Sergei
>
>
