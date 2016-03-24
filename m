From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 24 Mar 2016 16:07:20 -0500
Subject: [PATCH v6 1/5] of/serial: move earlycon early_param handling to
 serial
In-Reply-To: <1458823925-19560-2-git-send-email-aleksey.makarov@linaro.org>
References: <1458823925-19560-1-git-send-email-aleksey.makarov@linaro.org>
 <1458823925-19560-2-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <CAL_JsqJje4=U4+i3jfFDkRv2Px3cw5QzGHfq41OjRDNL6c_Q8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 7:51 AM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> From: Leif Lindholm <leif.lindholm@linaro.org>
>
> We have multiple "earlycon" early_param handlers - merge the DT one into
> the main earlycon one.  It's a cleanup that also will be useful
> to defer setting up DT console until ACPI/DT decision is made.
>
> Rename the exported function to avoid clashing with the function from
> arch/microblaze/kernel/prom.c
>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>

Acked-by: Rob Herring <robh@kernel.org>
