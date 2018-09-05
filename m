From: Alex.Gonzalez@digi.com (Gonzalez, Alex)
Date: Wed, 5 Sep 2018 10:25:37 +0000
Subject: [PATCH v2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
In-Reply-To: <CAOMZO5B26iFCY2DeBHa6_=uRT3zgdP5J+HBqzpPY-=7HHgP9EA@mail.gmail.com>
References: <1536074909-8654-1-git-send-email-alex.gonzalez@digi.com>
 <1536074909-8654-2-git-send-email-alex.gonzalez@digi.com>
 <CAOMZO5B26iFCY2DeBHa6_=uRT3zgdP5J+HBqzpPY-=7HHgP9EA@mail.gmail.com>
Message-ID: <20180905102536.GC15467@agonzal-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio, thanks for the review.

>Missing a panel attached to the lcdif?
>

My intention was to add the board support first, and then one or more panels 
as independent patches.

Doesn't that make more sense that adding a default panel with the board 
support?

Thanks,
Alex
