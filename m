From: abrestic@chromium.org (Andrew Bresticker)
Date: Fri, 31 Oct 2014 09:42:00 -0700
Subject: [PATCH RESEND V4 3/9] of: Update Tegra XUSB pad controller
 binding for USB
In-Reply-To: <CACRpkdbERA6rxrMTJQPGaNhAb=B3+KyQ1YBKNy2AqsLZD2eHDA@mail.gmail.com>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-4-git-send-email-abrestic@chromium.org>
 <CACRpkdbERA6rxrMTJQPGaNhAb=B3+KyQ1YBKNy2AqsLZD2eHDA@mail.gmail.com>
Message-ID: <CAL1qeaGkTY9kOfLu6qXFQ=RFKzycknLbOUixv4Y+cVf5oY6jkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 2:44 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Oct 28, 2014 at 11:27 PM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>
>> Add new bindings used for USB support by the Tegra XUSB pad controller.
>> This includes additional PHY types, USB-specific pinconfig properties, etc.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>> ---
>> Changes from v2:
>>  - Added nvidia,otg-hs-curr-level-offset property.
>>  - Dropped "-otg" from VBUS supplies.
>>  - Added mbox-names property.
>>  - Removed extra whitespace.
>> Changes from v1:
>>  - Updated to use common mailbox bindings.
>>  - Made USB3 port-to-lane mappins a top-level binding rather than a pinconfig
>>    binding.
>>  - Add #defines for the padctl lanes.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I guess you will take this patch along with the rest through ARM SoC
> or so?

Yes, that's the plan.
