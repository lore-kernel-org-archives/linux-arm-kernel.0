From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 05 Sep 2014 21:36:38 +0200
Subject: arm: Add basic support for MediaTek MT8127 & MT8135 SoCs
In-Reply-To: <1409874660-8710-1-git-send-email-srv_yingjoe.chen@mediatek.com>
References: <1409874660-8710-1-git-send-email-srv_yingjoe.chen@mediatek.com>
Message-ID: <15158935.ieDDcCvpAL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Joe,

On Friday 05 September 2014 07:50:55 Joe. C wrote:
> This series add basic device tree support MT8127 & MT8135.
> This series is based on v3.17-rc3.
>
> We are planning to upstream drivers for MT8127 & MT8135 SoCs.
> MT8135 is a tablet soc featuring 2 CA7 + 2 CA15. MT8127 is a
> tablet soc with 4 CA7. They share many similar IP components
> with MT65xx series.

The patches look very nice to me, I'm glad to hear you have
plans to upstream more.
 
> Please note this one is not base on intpol [1] patches I sent
> last month. Base on the discussion on intpol, I think it might
> take some more time. I'd like to have this merge first so we
> can work on other stuff simultaneously.

Yes, I agree. I'll wait for Matthias to pick up your patches
and send a pull request for them.

	Arnd
