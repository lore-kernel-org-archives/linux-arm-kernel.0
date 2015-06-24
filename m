From: tyler.baker@linaro.org (Tyler Baker)
Date: Wed, 24 Jun 2015 14:48:26 -0700
Subject: [PATCH] ARM: BCM5301X: Enable UART0 for SmartRG SR-400AC
In-Reply-To: <1435103504-28592-1-git-send-email-f.fainelli@gmail.com>
References: <1435103504-28592-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <CANMBJr73RhkrfsCBY1B_wxio=E5pXuZhowbds=5dx1EaerVBPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 June 2015 at 16:51, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Enable the use of UART0 by overriding its default status property.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Florian! I've tested this patch atop next-20150624 on the
smartrg-sr400ac, and confirmed UART0 is working properly.

Tested-by: Tyler Baker <tyler.baker@linaro.org>

Cheers,

Tyler
