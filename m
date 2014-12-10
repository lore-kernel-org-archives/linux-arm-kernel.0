From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 10 Dec 2014 10:09:22 +0100
Subject: [PATCH] arm: imx: correct the hardware clock gate setting for
 shared nodes
In-Reply-To: <BN1PR0301MB062806C16F41B55ADB753E4DFF620@BN1PR0301MB0628.namprd03.prod.outlook.com>
References: <1418111885-3623-1-git-send-email-b20788@freescale.com>
 <20141209085742.GE13486@pengutronix.de>
 <BN1PR0301MB062806C16F41B55ADB753E4DFF620@BN1PR0301MB0628.namprd03.prod.outlook.com>
Message-ID: <20141210090922.GH13486@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Dec 10, 2014 at 08:49:27AM +0000, Anson.Huang at freescale.com wrote:
> > 
> > esai_sel            0            0   393216000          0 0
> >    esai_pred           0            0   196608000          0 0
> >       esai_podf           0            0    24576000          0 0
> >          esai_extal           0            0    24576000          0 0
> >       esai_mem           0            0   132000000          0 0
> >       esai_ipg           0            0   132000000          0 0
> > 
> > Read CCM_CCGR1:
> > 
> > 0x020C406C:  F33FFF00
> This is hardly useful if you don't have the reference manual at hand.
> I'd believe the commit log even without the examples.
> [Anson] Agreed, I will remove it in V2 patch.
> 
> Many thanks for reviewing my patch and very good advice:) Please help review V2 patch.
>  
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
If you want to do me (and most of the other readers of lakml I guess)
another favour: please fix your quoting style. The way you replied to my
mail is hard to parse in a console mail reader as you might be able to
see from the text I quoted above.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
