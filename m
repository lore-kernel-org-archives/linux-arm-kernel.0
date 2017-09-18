From: robh@kernel.org (Rob Herring)
Date: Mon, 18 Sep 2017 15:37:33 -0500
Subject: [PATCH v5 2/3] arm: dts: add Nuvoton NPCM750 device tree
In-Reply-To: <20170918194625.xz5y7tkemjnbwunh@rob-hp-laptop>
References: <20170909015308.30001-1-brendanhiggins@google.com>
 <20170909015308.30001-3-brendanhiggins@google.com>
 <20170918194625.xz5y7tkemjnbwunh@rob-hp-laptop>
Message-ID: <CAL_Jsq+R6WXgHqYHypc49YAPVu_GH1SJ6LSKwcL-J_8Sc_aCmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 2:46 PM, Rob Herring <robh@kernel.org> wrote:
> On Fri, Sep 08, 2017 at 06:53:07PM -0700, Brendan Higgins wrote:
>> Add a common device tree for all Nuvoton NPCM750 BMCs and a board
>> specific device tree for the NPCM750 (Poleg) evaluation board.

[...]

>> +/ {
>> +     model = "Nuvoton npcm750 Development Board (Device Tree)";
>> +     compatible = "nuvoton,npcm750";
>> +
>> +     chosen {
>> +             stdout-path = &serial3;
>
> stdout-path is a path string, not a phandle.

Sorry, it's Monday and my brain is not working. This is fine.

Rob
