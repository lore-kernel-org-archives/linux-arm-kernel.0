From: julian.calaby@gmail.com (Julian Calaby)
Date: Thu, 24 Sep 2015 09:42:33 +1000
Subject: [linux-sunxi] [PATCH v2 2/4] ARM: dts: sun4i: gemei-g9: Convert
 to use axp209 regulator nodes
In-Reply-To: <1442993914-20295-3-git-send-email-plaes@plaes.org>
References: <1442993914-20295-1-git-send-email-plaes@plaes.org>
 <1442993914-20295-3-git-send-email-plaes@plaes.org>
Message-ID: <CAGRGNgVLV_hSSTEPuC2_ga6H=wHNFuOktvCE2Mvk_txg8zCLgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Priit,

On Wed, Sep 23, 2015 at 5:38 PM, Priit Laes <plaes@plaes.org> wrote:
> Add regulator nodes for axp209 by including the axp209 dtsi.
>
> Changes in v2:
>  - Add the ohci0 node.

Firstly, changelog stuff like this should be below the --- under your SOB.

Also, shouldn't enabling the ohci0 node be a separate patch?

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
