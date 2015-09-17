From: alison.wang@freescale.com (Huan Wang)
Date: Thu, 17 Sep 2015 09:53:57 +0000
Subject: [PATCH v2] audio: sai: Add Power Management support
In-Reply-To: <20150917065732.GB54360@Asurada-CZ80>
References: <1442221404-35240-1-git-send-email-b18965@freescale.com>
 <20150917065732.GB54360@Asurada-CZ80>
Message-ID: <BN3PR0301MB0867DCDF1F7F6391A94121B2FE5A0@BN3PR0301MB0867.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Mon, Sep 14, 2015 at 05:03:24PM +0800, Alison Wang wrote:
> > This patch adds Power Management support for SAI.
> > Activate regmap cache with REGCACHE_FLAT, and use regmap cache code
> to
> > save and restore registers in suspend and resume. The Transmit
> Control
> > Register
> > (TCSR) and Receive Control Register(RCSR) should be volatile
> > registers.
> >
> > Signed-off-by: Alison Wang <alison.wang@freescale.com>
> 
> Just to remind that there was a similar patch in review that I just
> acked. Please send your improvements as an incremental patch after that
> one gets applied.
[Alison Wang] Ok, I missed that patch.
> 
> Please also pay attention to the patch subject which should follow the
> pattern of previous patches of the driver: ASoC: fsl_sai: xxxx
[Alison Wang] Ok, thanks.


Best Regards,
Alison Wang
