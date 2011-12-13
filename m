From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 Dec 2011 10:36:27 +0800
Subject: [PATCH 1/1] net/fec: add KSZ9021RN phy fixup
In-Reply-To: <20111213021008.GE28768@b20223-02.ap.freescale.net>
References: <1323684558-16796-1-git-send-email-richard.zhao@linaro.org>
 <CAOMZO5DNRrt7ULuBkh9y8bz2_fpCHOcSWxAbJOqTHA2Nrv1V_w@mail.gmail.com>
 <20111212135119.GE16835@b20223-02.ap.freescale.net>
 <4EE612BF.9050907@bluegiga.com>
 <20111213021008.GE28768@b20223-02.ap.freescale.net>
Message-ID: <20111213023626.GA10866@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 10:10:08AM +0800, Richard Zhao wrote:
> By converting to DT, machine code's becoming common too. I feel hard to
> find a place. Put it in imx6q_init_machine?
> 
> Sascha & Shawn, Could you give comments here?
> 
I see no problem to do that by checking board compatible string and
do the setup for particular board.

-- 
Regards,
Shawn
