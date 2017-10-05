From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 05 Oct 2017 12:31:42 +0200
Subject: [RESEND][PATCH 1/7] nvmem: imx-ocotp: Restrict OTP write to
 IMX6 processors
In-Reply-To: <1507155921-824-2-git-send-email-pure.logic@nexus-software.ie>
References: <1507155921-824-1-git-send-email-pure.logic@nexus-software.ie>
 <1507155921-824-2-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1507199502.8473.7.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-10-04 at 23:25 +0100, Bryan O'Donoghue wrote:
> i.MX7S/D have a different scheme for addressing the OTP registers
> inside
> the OCOTP block. Currently it's possible to address the wrong OTP
> registers
> given the disparity between IMX6 and IMX7 OTP addressing.
> 
> Since OTP programming is one-time destructive its important we
> restrict
> this interface ASAP.
> 
> Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")
> 
> Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
