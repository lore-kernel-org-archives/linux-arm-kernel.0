From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 17:11:23 +0000
Subject: [PATCH 3/6] mfd: add bcm59056 pmu driver
In-Reply-To: <20140204170832.GA5196@lee--X1>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-4-git-send-email-mporter@linaro.org>
 <20140204132951.GE13529@lee--X1> <20140204143119.GA4627@beef>
 <20140204165906.GC22609@sirena.org.uk>
 <20140204170832.GA5196@lee--X1>
Message-ID: <20140204171123.GE22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 05:08:32PM +0000, Lee Jones wrote:

> > What using of_match_ptr() should do is allow the compiler to figure out
> > that the table isn't used when DT is disabled and discard it without
> > ifdefs.  Not sure if that actually works yet but that's the idea.

> Right, but I'm guessing that as there is no support for platform data
> then this device(s) is going to be DT only? If that's the case perhaps
> a 'depends OF' might be in order. If that's not the case then I'm more
> than happy to leave the of_match_ptr() in.

Hey, we'll all be using ACPI soon!  :P
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/9134d4b4/attachment.sig>
