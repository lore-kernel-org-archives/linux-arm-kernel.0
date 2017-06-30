From: broonie@kernel.org (Mark Brown)
Date: Fri, 30 Jun 2017 12:56:00 +0100
Subject: [alsa-devel] [PATCH v2 12/12] ASoC: Fix use-after-free at card
 unregistration
In-Reply-To: <87o9t7u5v5.fsf@belgarion.home>
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
 <1497857229-12049-13-git-send-email-robert.jarzmik@free.fr>
 <s5hefug72iu.wl-tiwai@suse.de> <87injstckf.fsf@belgarion.home>
 <20170628195349.pqeb3dceddxar75s@sirena.org.uk>
 <87o9t7u5v5.fsf@belgarion.home>
Message-ID: <20170630115600.btemrql3aso4s45z@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 12:03:58AM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Based on the missing first patch I was expecting the series to get
> > reposted?

> The first patch is only moving around a .h file. I was expecting a review before
> reposting a v3.

I can't tell what's in the first patch if you didn't send it.... :(
In general it's best to resend for things like this, I know I focus my
review on things that can progress as-is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170630/de436aca/attachment.sig>
