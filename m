From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Sep 2018 11:07:03 +0200
Subject: [PATCH v2 0/8] drm/bridge: add bus flag support
In-Reply-To: <20180912183222.25414-1-stefan@agner.ch>
References: <20180912183222.25414-1-stefan@agner.ch>
Message-ID: <CACRpkdZdxLMkECq8BBJHDqKszHPMt2uUPFbwbPVNKXyxu-SWGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2018 at 8:32 PM Stefan Agner <stefan@agner.ch> wrote:

> @Linus Walleij, Laurent Pinchart: Since you have been involved in
> the initial bus timings discussion, I would like to have your Ack
> on at least patch 2/3... If we want to keep the setup/hold timings,
> the patchset should also work without those two patches.

AFAICT this ends up with the PL111 code identical to what I
proposed in my first patch set to support the latching properly,
so I am pretty much happy as long as my hardware does not
flicker. (Rough consensus and running code.) I'm not very invested
in either idea to represent these timings, so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
