From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 20 Feb 2014 09:54:47 +0100
Subject: [PATCH v3 02/15] mfd: max14577: Rename and add MAX14577 symbols to
 prepare for max77836
In-Reply-To: <20140219141102.GA2669@sirena.org.uk>
References: <1392627950-26927-1-git-send-email-k.kozlowski@samsung.com>
 <1392627950-26927-3-git-send-email-k.kozlowski@samsung.com>
 <1392813881.17652.14.camel@AMDC1943> <20140219141102.GA2669@sirena.org.uk>
Message-ID: <1392886487.3648.12.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-02-19 at 23:11 +0900, Mark Brown wrote:
> On Wed, Feb 19, 2014 at 01:44:41PM +0100, Krzysztof Kozlowski wrote:
> 
> > I want to push whole MAX77836 patchset through Lee Jones' MFD tree and I
> > still need acks from power and regulator subsystems.
> 
> > I would appreciate if you could find time to look at these patches and
> > let me know your opinion (or just add Acked-by):
> > [PATCH v3 02/15] mfd: max14577: Rename and add MAX14577 symbols...
> > [PATCH v3 03/15] mfd: max14577: Rename state container to maxim_core
> > [PATCH v3 04/15] mfd: max14577: Add "muic" suffix to regmap and irq_chip
> 
> I don't have these patches, I expect it looked like the series was going
> to get a respin.

Hmmm, I'll send the next version of this patchset.

> 
> To be honest the number of large patch serieses you've been sending
> iterations of (sometimes partial series without context too) doesn't
> push them up the priority list, it'd help to rate limit things a bit.

I understand, especially that such drivers touch multiple subsystems.

Best regards,
Krzysztof
