From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Mar 2014 12:53:51 +0000
Subject: [PATCH] cpufreq: enable ARM drivers on arm64
In-Reply-To: <531F0115.4000109@arm.com>
References: <1393208877-15797-1-git-send-email-broonie@kernel.org>
 <531F0115.4000109@arm.com>
Message-ID: <20140311125351.GQ28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 12:27:01PM +0000, Sudeep Holla wrote:

> Sorry for late response, looks like Rafael has pulled this change, but ...

> >+menu "Power management options"
> >+
> >+source "kernel/power/Kconfig"
> >+
> >+source "drivers/cpufreq/Kconfig"
> >+
> >+endmenu

> Is this patch based on recent kernels ? If so, either it should have caused
> conflicts or silently duplicated the entries. "Power management options" are
> already present.

Yes, it was against -next.  It looks like either the original patch had
the duplication or it crept in there during the rather lengthy time
between submission and acceptance.

> Also to be more consistent it with menu options, I would prefer this to be
> placed under "CPU Power Management" like CPUIdle.

I'll submit an incremental patch for this; in general the best thing to
do once things have been applied is to send a patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140311/bf531325/attachment.sig>
