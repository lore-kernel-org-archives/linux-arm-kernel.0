From: olof@lixom.net (Olof Johansson)
Date: Sat, 14 Apr 2012 17:47:50 -0700
Subject: [PATCH] ARM: dts: remove blank interrupt-parent properties
In-Reply-To: <1334243848-29522-1-git-send-email-robherring2@gmail.com>
References: <1334243848-29522-1-git-send-email-robherring2@gmail.com>
Message-ID: <CAOesGMhxxAN+Uo-o3hV81Z+e7YHwvQ9cnDYE+7n+3qj3RVsFDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 8:17 AM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> These were incorrectly introduced and can cause problems for of_irq_init.
>
> The correct way to define a root controller is no interrupt-parent set at
> all or the interrupt-parent is set to the root controller itself when
> inherited from a parent node.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
> Arnd, Olof,
>
> Please apply for 3.4.

Thanks, applied.


-Olof
