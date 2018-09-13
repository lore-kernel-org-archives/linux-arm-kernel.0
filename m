From: joel@jms.id.au (Joel Stanley)
Date: Fri, 14 Sep 2018 08:59:59 +0930
Subject: [PATCH] arm: dts: aspeed: quanta-q71l: Enable adc & ibt nodes
In-Reply-To: <20180904155329.258447-1-venture@google.com>
References: <20180904155329.258447-1-venture@google.com>
Message-ID: <CACPK8XfH74Z1FYvWxU-vkxJ-APKG_w14dWMjLnj87eH-zrt02w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 5 Sep 2018 at 01:23, Patrick Venture <venture@google.com> wrote:
>
> ADC node is disabled by default in 4.13 tree onward and
> needs to be enabled explicitly in separate device trees.
>
> ibt(ipmi-bt-host) node is disabled by default in 4.13 tree onward and
> needs to be enabled explicitly in separate device trees.
>
> Signed-off-by: Patrick Venture <venture@google.com>

Applied to dt-for-v4.20 with a tweak to the commit message. (FYI: the
4.13 messages relate to the openbmc tree; the upstream tree introduced
these drivers earlier, and it has always been disabled in the dtsi).

Cheers,

Joel
