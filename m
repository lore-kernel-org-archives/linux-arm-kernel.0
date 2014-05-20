From: mporter@linaro.org (Matt Porter)
Date: Tue, 20 May 2014 17:57:26 -0400
Subject: [PATCH v2 2/4] mfd: bcm590xx: add support for secondary I2C
 slave address
In-Reply-To: <20140520214439.GS12304@sirena.org.uk>
References: <1398295293-11033-1-git-send-email-mporter@linaro.org>
 <1398295293-11033-3-git-send-email-mporter@linaro.org>
 <20140428115627.GY21279@lee--X1> <20140428140910.GB7719@beef>
 <20140520161131.GB32025@lee--X1>
 <20140520190055.GQ12304@sirena.org.uk>
 <20140520202923.GT32082@beef>
 <20140520214439.GS12304@sirena.org.uk>
Message-ID: <20140520215726.GU32082@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 10:44:39PM +0100, Mark Brown wrote:
> On Tue, May 20, 2014 at 04:29:23PM -0400, Matt Porter wrote:
> 
> > Just resent the v2 series.
> 
> I looked at that but it seems I already acked the regulator part of the
> series and nothing else looked immediately relevant?

The series has cross dependencies (shared header include) and thus needs
to have both the mfd and regulator portions merged together. You had
mentioned in the v1 version that you'd like to take it through the
regulator tree and so Lee's comments earlier were with regard to you
taking the mfd portions.

-Matt
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/7981cc23/attachment.sig>
