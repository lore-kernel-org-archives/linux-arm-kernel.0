From: robh@kernel.org (Rob Herring)
Date: Mon, 8 Feb 2016 13:50:28 -0600
Subject: [PATCH v2 2/4] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <1454697741-8687-3-git-send-email-contact@paulk.fr>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
 <1454697741-8687-3-git-send-email-contact@paulk.fr>
Message-ID: <20160208195028.GA13120@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 07:42:19PM +0100, Paul Kocialkowski wrote:
> LP872x regulators are made active via the EN pin, which might be hooked to a
> GPIO. This adds support for driving the GPIO high when the driver is in use.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  .../devicetree/bindings/regulator/lp872x.txt       |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/regulator/lp872x.c                         | 34 ++++++++++++++++++++++
>  include/linux/regulator/lp872x.h                   |  5 ++++
>  3 files changed, 40 insertions(+)
