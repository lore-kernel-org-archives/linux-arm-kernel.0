From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Mar 2017 14:11:00 +0100
Subject: [PATCH v2 3/5] dt-bindings: fix for Allwinner H5 pinctrl's
 compatible
In-Reply-To: <20170301180111.12365-4-icenowy@aosc.xyz>
References: <20170301180111.12365-1-icenowy@aosc.xyz>
 <20170301180111.12365-4-icenowy@aosc.xyz>
Message-ID: <CACRpkdZMwNoD2CGe2Hy6OXoDcjiQah_JOndVyFDUbBpFim=1aQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 1, 2017 at 7:01 PM, Icenowy Zheng <icenowy@aosc.xyz> wrote:

> The compatible for Allwinner H5 pin controller is wrong written as
> allwinner,sun50i-h5-r-pinctrl, however, it's really a generic pinctrl
> rather than a "r" one.
>
> Fix this compatible string.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
