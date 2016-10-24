From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Oct 2016 11:17:08 -0200
Subject: [PATCH] ARM: imx: mach-imx6q: Fix the PHY ID mask for AR8031
In-Reply-To: <20161024131434.GL30578@tiger>
References: <1477312332-2027-1-git-send-email-festevam@gmail.com>
 <20161024131434.GL30578@tiger>
Message-ID: <CAOMZO5CBzNnpYqNLvXZ4fWjp5UmDcztA5vVwfZxOxiFCzDeZgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 11:14 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Mon, Oct 24, 2016 at 10:32:12AM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@nxp.com>
>>
>> AR8031 and AR8035 have the same PHY ID mask of 0xffffffef.
>>
>> So fix it and make it match with the PHY ID mask definition
>> at drivers/net/phy/at803x.c.
>
> It was working well with a wrong ID?

Yes, it was working well even with the wrong PHY ID mask.
