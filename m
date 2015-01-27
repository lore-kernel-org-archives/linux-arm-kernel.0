From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 27 Jan 2015 13:57:33 +0100
Subject: [PATCH v2 06/11] ARM: tegra: Move out nyan-generic parts out from
 the nyan-big DT
In-Reply-To: <54B7F8D2.4040400@wwwdotorg.org>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421338359-27467-7-git-send-email-tomeu.vizoso@collabora.com>
 <54B7F8D2.4040400@wwwdotorg.org>
Message-ID: <CAAObsKBfBREzQueA8NRJ0msi7g=5s9Sd2riSEF+0jp8JSbT-mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2015 at 18:28, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
>>
>> In preparation for adding the DT for the nyan-blaze board.
>
>
> "git format-patch -C" might help here; hopefully it'd highlight that
> arch/arm/boot/dts/tegra124-nyan.dtsi was a copy from
> arch/arm/boot/dts/tegra124-nyan-big.dts, with just a few small diffs?

It doesn't, because we keep the pinmux config in the leaf files.

Regards,

Tomeu
