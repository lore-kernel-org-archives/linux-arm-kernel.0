From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Nov 2015 15:44:04 +0100
Subject: [PATCH] pinctrl: qcom: qdf2xxx: improve error checking and
 reporting
In-Reply-To: <564B2D57.2080508@codeaurora.org>
References: <1447171030-15056-1-git-send-email-timur@codeaurora.org>
 <CACRpkdb4Ck4XCUEKX7TEgCg8723vZA-sxqmd753O1q9uTBszfQ@mail.gmail.com>
 <564B2D57.2080508@codeaurora.org>
Message-ID: <CACRpkdYhwEqiVJtD_Qn655-Fq5W3Q5yvMkt_dkHum4dkfLvBsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 2:36 PM, Timur Tabi <timur@codeaurora.org> wrote:
> Linus Walleij wrote:
>>
>> And I suspect Arnd would be interested to know if you are doing
>> ACPI on something that is certainly not a server-class hardware.
>> Because you shouldn't.
>
> This driver is for the TLMM pin control device on Qualcomm's ARM64 Server
> chip.

Ohhh sweet. OK then.

Yours,
Linus Walleij
