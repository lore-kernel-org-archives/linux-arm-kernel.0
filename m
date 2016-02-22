From: robh@kernel.org (Rob Herring)
Date: Mon, 22 Feb 2016 14:02:37 -0600
Subject: [PATCH] dma: mv_xor_v2: new driver
In-Reply-To: <20160222082130.75e9c540@free-electrons.com>
References: <1455523083-25506-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160222025349.GC15973@rob-hp-laptop>
 <20160222082130.75e9c540@free-electrons.com>
Message-ID: <CAL_JsqLb_j+DjfggdDKf8OqheaAqzyDpt1EECQ7XrGqAHoTCnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 1:21 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Rob,
>
> On Sun, 21 Feb 2016 20:53:49 -0600, Rob Herring wrote:
>
>> > +Required properties:
>> > +- compatible: Should be "marvell,mv-xor-v2"
>>
>> and an SoC specific compatible please.
>
> So you mean *both* marvell,mv-xor-v2 and a SoC specific compatible?

Yes. Well, really I'd like to see only SoC specific compatibles, but
everyone likes to have their generic ones for matching since it's
always "the same hardware".

Rob
