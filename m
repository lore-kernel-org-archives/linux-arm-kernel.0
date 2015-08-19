From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Aug 2015 23:29:22 +0800
Subject: [linux-sunxi] Re: [PATCH 2/3] ARM: dts: sun6i: Turn on gmac on
 Colombus
In-Reply-To: <20150819151754.GH30520@lukather>
References: <1438960955-6551-1-git-send-email-hdegoede@redhat.com>
 <1438960955-6551-2-git-send-email-hdegoede@redhat.com>
 <20150819151754.GH30520@lukather>
Message-ID: <CAGb2v64gqDfV_s2Q1CmSD51m+LC1krgJMtSxT4a1rvTmTUncaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 19, 2015 at 11:17 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Aug 07, 2015 at 05:22:34PM +0200, Hans de Goede wrote:
>> We've everything we need to support the gmac on Colombus, turn it on.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>
> I recall that the phy was powered by one of the AXP221 regulators,
> does it require some additional stuff (like a recent u-boot), or does
> it just work and my memory is bad :) ?

I sort of remember that as well.

FYI i have a patch to add axp221.dtsi, though I haven't converted
the hummingbird dts yet.

ChenYu
