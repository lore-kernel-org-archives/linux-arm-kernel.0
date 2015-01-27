From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 27 Jan 2015 13:47:22 +0100
Subject: [PATCH v5 1/5] ARM: mediatek: Add config options for mediatek
 SoCs.
In-Reply-To: <CABuKBeLPN74fiLduvswHfPrgAoQCFXCtdLZhhoha8Q=0xBSjpA@mail.gmail.com>
References: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
 <1421818097-9281-2-git-send-email-hongzhou.yang@mediatek.com>
 <CABuKBeJGigY5ym9cJy=PYK8jbdsOLLtkmovHq6xho4gYseCAWg@mail.gmail.com>
 <1422353800.14015.35.camel@x220> <1422354400.32212.25.camel@mtksdaap41>
 <1422354858.14015.39.camel@x220>
 <CABuKBeLPN74fiLduvswHfPrgAoQCFXCtdLZhhoha8Q=0xBSjpA@mail.gmail.com>
Message-ID: <1422362842.14015.48.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Matthias,

On Tue, 2015-01-27 at 13:38 +0100, Matthias Brugger wrote:
> Yes, this symbols are needed when we implement the pinctrl driver for
> the other platforms.
> I will implement mt6589 as soon as the pinctrl driver got merged.
> I suppose Howard will go for the mt6592.

I see. Unless the users of MACH_MT6589, MACH_MT6592, MACH_MT8127, and
MACH_MT8135 take very long to land in linux-next (or in mainline) I
won't bother you again about this.

Thanks!


Paul Bolle
