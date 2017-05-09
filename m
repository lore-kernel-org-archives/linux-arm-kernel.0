From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 9 May 2017 09:15:47 -0500
Subject: [v3, 1/5] mmc: dt: add compatible into eSDHC required properties
In-Reply-To: <1494297429-12083-2-git-send-email-yangbo.lu@nxp.com>
References: <1494297429-12083-1-git-send-email-yangbo.lu@nxp.com>
 <1494297429-12083-2-git-send-email-yangbo.lu@nxp.com>
Message-ID: <CAL_JsqKUAQYptg7ajaHZiFgtPvzPjfF6DwDH9W0cHYFy=GXscw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 8, 2017 at 9:37 PM, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> This patch is to add compatible into eSDHC required properties.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
>         - Added this patch.
> Changes for v3:
>         - Added possible comaptible list
> ---
>  Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
