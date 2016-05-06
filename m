From: broonie@kernel.org (Mark Brown)
Date: Fri, 6 May 2016 18:17:04 +0100
Subject: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
In-Reply-To: <87h9ecp9tp.fsf@belgarion.home>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
 <20160503115159.GP6292@sirena.org.uk>
 <87y47roski.fsf@belgarion.home>
 <20160504090702.GV6292@sirena.org.uk>
 <87pot0pbnf.fsf@belgarion.home>
 <20160505191728.GK6292@sirena.org.uk>
 <87h9ecp9tp.fsf@belgarion.home>
Message-ID: <20160506171704.GY6292@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2016 at 09:46:10PM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Thu, May 05, 2016 at 09:06:44PM +0200, Robert Jarzmik wrote:
> >> Mark Brown <broonie@kernel.org> writes:

> >> This transition will be easier if the new ac97 code is isolated as much as
> >> possible from the former code while providing backward compatibility ... hence
> >> this patch.

> > It'd probably have been clearer to me if it were splitting out all the
> > register definitions rather than just some of them.

> Euh unless I'm missing something I have splitted out all the ac97 generic
> registers AFAIK. The only remaining ones are chip specific which I didn't take
> as they should be in codec specific code and not ac97 generic one.

The changelog read like it was trying to split things used by the
controller vs things used by CODEC drivers, I didn't get as far as
checking all the registers TBH.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160506/e5df7443/attachment.sig>
