From: yong.shen@linaro.org (Yong Shen)
Date: Tue, 11 Jan 2011 16:58:26 +0800
Subject: [PATCH 0/2] ARM i.MX53 enable SMD and LOCO board bootup
In-Reply-To: <20110111082520.GB22418@jasper.tkos.co.il>
References: <1294726998-20830-1-git-send-email-yong.shen@freescale.com>
	<20110111072301.GA19168@jasper.tkos.co.il>
	<AANLkTikhf7ReDZRt+CRuzupD_oQb7LMfTDa2fvpjayRB@mail.gmail.com>
	<20110111082520.GB22418@jasper.tkos.co.il>
Message-ID: <AANLkTikoQS8KF95MgKTG_FtK5AcRt-paJKLCicCLNLJ5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

>
> Code for two (or more) different machines can be shared in the same file. See
> for example the code in arch/arm/mach-at91/board-stamp9g20.c which supports
> both taskit PortuxG20 and taskit Stamp9G20, and
> arch/arm/mach-at91/board-pcontrol-g20.c which is reusing code from these
> boards for a third board (PControl G20).
>
> We should avoid code duplication as much as possible, IMO.
>
I agree the rule you mentioned about: avoid code duplication, and I
also know that one file can hold multiple board definitions. However,
in this case, these two boards were designed for different purpose.
For example, SMD is for smart mobile device, while LOCO is more
generic for multiple usage. As time goes on, the code for each boards
are supposed to be much more different than it is now.
So I still stick on my opinion, hope you can understand.

thanks
Yong
