From: nicoleotsuka@gmail.com (Nicolin Chen)
Date: Wed, 16 Sep 2015 23:57:33 -0700
Subject: [PATCH v2] audio: sai: Add Power Management support
In-Reply-To: <1442221404-35240-1-git-send-email-b18965@freescale.com>
References: <1442221404-35240-1-git-send-email-b18965@freescale.com>
Message-ID: <20150917065732.GB54360@Asurada-CZ80>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 05:03:24PM +0800, Alison Wang wrote:
> This patch adds Power Management support for SAI.
> Activate regmap cache with REGCACHE_FLAT, and use
> regmap cache code to save and restore registers in
> suspend and resume. The Transmit Control Register
> (TCSR) and Receive Control Register(RCSR) should
> be volatile registers.
> 
> Signed-off-by: Alison Wang <alison.wang@freescale.com>

Just to remind that there was a similar patch in review that I just
acked. Please send your improvements as an incremental patch after
that one gets applied.

Please also pay attention to the patch subject which should follow
the pattern of previous patches of the driver: ASoC: fsl_sai: xxxx

Thanks
Nicolin
