From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 Feb 2017 14:05:28 +0100
Subject: [PATCH 2/2] ARM: dts: Qualcomm APQ8060 DragonBoard ALS sensor
In-Reply-To: <20170201183631.GJ10531@minitux>
References: <20170131102114.25085-1-linus.walleij@linaro.org>
 <20170131102114.25085-2-linus.walleij@linaro.org>
 <20170201183631.GJ10531@minitux>
Message-ID: <CACRpkdbH9WgC8EwERRNDUjnAAz7YAq-=S1Wja5Hq2w0uDeO7rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 1, 2017 at 7:36 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue 31 Jan 02:21 PST 2017, Linus Walleij wrote:

>> +                                                     /* Let's use channel 5 */
>> +                                                     qcom,amux-route = <PMIC_MPP_AMUX_ROUTE_CH5>;
>
> Unrelated to this patch, I did look at how this works on later devices.
> It seems like we want to be able to switch the amux-route depending on
> which ADC "channel" we're querying - e.g. on DB820c we have thermistors
> on 3 different AMUX inputs but we don't have 3 mpps available.
>
> Any thoughts on how to deal with this?

The AMUX is just one big mystery to me, it's one of those areas where I
think a real datasheet would be extremely helpful.

In absence of datasheet, maybe a piece of ASCII art illustrating the muxes
in the device tree binding docs or so, written by someone who understand
it.

In absence of any written sources, maybe hearsay, rumors, palimpsest...
hehe.

I'd seriously like to know how this is engineered.

Yours,
Linus Walleij
