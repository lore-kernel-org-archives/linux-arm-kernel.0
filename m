From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 Jun 2017 11:19:32 +0200
Subject: [PATCH 1/3] dt-bindings: pinctrl: sunxi: Add compatible string
 for A83T R_PIO
In-Reply-To: <20170603144427.22855-2-wens@csie.org>
References: <20170603144427.22855-1-wens@csie.org>
 <20170603144427.22855-2-wens@csie.org>
Message-ID: <CACRpkdaZbCHRZO5OwXjmx1LsEqLa4TUqBNr2jmRtML_8wGfs_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 3, 2017 at 4:44 PM, Chen-Yu Tsai <wens@csie.org> wrote:

> The R_PIO on the A83T is almost the same as the one found on the A64,
> except that the CIR_RX function was moved from pin PL11 to pin PL12.
>
> Add a compatible string for it.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Patch applied with Rob's ACK.

Yours,
Linus Walleij
