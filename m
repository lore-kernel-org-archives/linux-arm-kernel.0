From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 15:36:11 +0200
Subject: [PATCH v2 4/9] pinctrl: tegra-xusb: Add USB PHY support
In-Reply-To: <53FB8CFE.3090007@wwwdotorg.org>
References: <1408381705-3623-1-git-send-email-abrestic@chromium.org>
 <1408381705-3623-5-git-send-email-abrestic@chromium.org>
 <53FB8CFE.3090007@wwwdotorg.org>
Message-ID: <CACRpkdZD2Ww44ExnLQgJvaw64rSiTZAMdphBV3gQSMZpRPj50g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 9:22 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/18/2014 11:08 AM, Andrew Bresticker wrote:
>>
>> In addition to the PCIe and SATA PHYs, the XUSB pad controller also
>> supports 3 UTMI, 2 HSIC, and 2 USB3 PHYs.  Each USB3 PHY uses a single
>> PCIe or SATA lane and is mapped to one of the three UTMI ports.
>>
>> The xHCI controller will also send messages intended for the PHY driver,
>> so request and listen for messages on the mailbox's PHY channel.
>
>
> I'd like a review from Thierry here as the HW expert.
>
> I need an ack from LinusW in order to take this pinctrl patch through the
> Tegra tree.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
