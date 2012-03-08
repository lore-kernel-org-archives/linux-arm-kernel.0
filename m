From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 8 Mar 2012 12:02:07 +0000
Subject: [PATCH v2 00/17] ASoC: add imx-sgtl5000 machine driver working
 with fsl_ssi
In-Reply-To: <4F57ECC7.1040100@freescale.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
 <4F57ECC7.1040100@freescale.com>
Message-ID: <20120308120207.GJ3638@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 05:18:31PM -0600, Timur Tabi wrote:

> I've tested this patchset, and after adding the changes that I pointed out
> in my previous email, audio still works on the P1022DS and MPC8610HPCD.

> Therefore:

> Acked-by: Timur Tabi <timur@freescale.com>

Excellent, it's great to see the SSI drivers merged!  Shawn, could you
please resend the unapplied patches with all the relevant acks collected
and tweaks that people requested just to make sure I've got everything.

I know Sascha wanted some slightly larger changes to the new card driver
so if you want to hold off on that until you've done the updates that's
fine but it'd be good to get all the other stuff merging the drivers
together for 3.4 if we can.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120308/b7f5a6b2/attachment.sig>
