From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 15 May 2014 15:50:17 +0100
Subject: [PATCH 1/3] arm: dts: add device_type="memory" for ste-ccu8540
In-Reply-To: <CACRpkda6+0LyHsqP5J-OTHaau1QPJaJRAup1d3KQq5zu2XC=HA@mail.gmail.com>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <1397756521-29387-2-git-send-email-leif.lindholm@linaro.org>
 <CACRpkda6+0LyHsqP5J-OTHaau1QPJaJRAup1d3KQq5zu2XC=HA@mail.gmail.com>
Message-ID: <CACxGe6sfjZxCuOTHwRswWW2rMQ_gJyxS+R=+5HQHnzT-BNzekg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 2:26 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Apr 17, 2014 at 7:41 PM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>
>> The current .dts for ste-ccu8540 lacks a 'device_type = "memory"' for
>> its memory node, relying on an old ppc quirk in order to discover its
>> memory. Add this, to permit that quirk to be made ppc only.
>>
>> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree at vger.kernel.org
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> There are no systems like this deployed so this patch set will not
> affect anything in the wild.

I may as well take all three of these patches through my tree (I've
changed my mind on the last one). There are actually not a huge number
of systems with ram starting at 0, so the impact is contained.

Applied, thanks.

g.
