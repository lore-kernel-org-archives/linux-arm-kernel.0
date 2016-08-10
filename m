From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Aug 2016 13:58:31 -0500
Subject: [PATCH resend] mmc: pwrseq-simple: Add an optional
 post-power-on-delay
In-Reply-To: <1470596558-23195-2-git-send-email-hdegoede@redhat.com>
References: <1470596558-23195-1-git-send-email-hdegoede@redhat.com>
 <1470596558-23195-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20160810185831.GA19639@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 07, 2016 at 09:02:38PM +0200, Hans de Goede wrote:
> Some devices need a while to boot their firmware after providing clks /
> de-asserting resets before they are ready to receive sdio commands.
> 
> This commits adds a post-power-on-delay-ms devicetree property to
> mmc-pwrseq-simple for use with such devices.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
>  drivers/mmc/core/pwrseq_simple.c                            | 9 +++++++++
>  2 files changed, 11 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
