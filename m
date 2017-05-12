From: robh@kernel.org (Rob Herring)
Date: Fri, 12 May 2017 15:12:16 -0500
Subject: [PATCH 3/6] dt-bindings: serial: fsl-lpuart: add i.MX7ULP support
In-Reply-To: <1494316248-24052-4-git-send-email-aisheng.dong@nxp.com>
References: <1494316248-24052-1-git-send-email-aisheng.dong@nxp.com>
 <1494316248-24052-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170512201216.vaa2dbwjq7dmouku@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 09, 2017 at 03:50:45PM +0800, Dong Aisheng wrote:
> The lpuart of imx7ulp is basically the same as ls1021a. It's also
> 32 bit width register, but unlike ls1021a, it's little endian.
> Besides that, imx7ulp lpuart has a minor different register layout
> from ls1021a.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Fugang Duan <fugang.duan@nxp.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Mingkai Hu <Mingkai.Hu@nxp.com>
> Cc: Yangbo Lu <yangbo.lu@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
