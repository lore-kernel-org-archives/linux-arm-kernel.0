From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Oct 2016 11:39:44 -0500
Subject: [PATCH v3 4/4] net: smsc91x: add u16 workaround for pxa platforms
In-Reply-To: <1476733532-29716-5-git-send-email-robert.jarzmik@free.fr>
References: <1476733532-29716-1-git-send-email-robert.jarzmik@free.fr>
 <1476733532-29716-5-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20161018163944.jaqtthlka6t7pxhn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 09:45:32PM +0200, Robert Jarzmik wrote:
> Add a workaround for mainstone, idp and stargate2 boards, for u16 writes
> which must be aligned on 32 bits addresses.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> ---
> Since v1: rename dt property to pxa-u16-align4
>       	  change the binding documentation file
> ---
>  Documentation/devicetree/bindings/net/smsc-lan91c111.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
