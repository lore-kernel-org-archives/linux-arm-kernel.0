From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 7 Mar 2017 12:48:19 +0100
Subject: [PATCH v2 1/6] of: documentation: add bindings documentation for
 TS-4600
In-Reply-To: <20170203194729.20995-2-sebastien.bourdelin@savoirfairelinux.com>
References: <20170203194729.20995-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170203194729.20995-2-sebastien.bourdelin@savoirfairelinux.com>
Message-ID: <20170307114818.GB6585@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 03, 2017 at 02:47:24PM -0500, Sebastien Bourdelin wrote:
> This adds the documentation for the TS-4600 by Technologic Systems.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> Changes v1 -> v2:
>   - rebase on master
>   - add ack by Rob Herring <robh@kernel.org>
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>

Your SoB should be put before the first '---'.  Otherwise, it will get
lost during patch applying.

Shawn

> ---
>  Documentation/devicetree/bindings/arm/technologic.txt | 5 +++++
>  1 file changed, 5 insertions(+)
