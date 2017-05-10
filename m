From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 May 2017 15:34:28 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.12
In-Reply-To: <cover.1493713942.git.horms+renesas@verge.net.au>
References: <cover.1493713942.git.horms+renesas@verge.net.au>
Message-ID: <CAK8P3a3Z2XL8zdWoQ9icQTioQaGQKGKaR=QCTq89h01Op=xmNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 2, 2017 at 10:35 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC fixes for v4.12.
>
> * Fix from Geert Uytterhoeven to avoid an undefined reference
>   to `rcar_rst_read_mode_pins' in the case where the R-Car RST driver
>   is not included.
>
>

Pulled into fixes, thanks!

     Arnd
