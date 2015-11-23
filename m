From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 23 Nov 2015 10:49:55 +0100
Subject: [PATCH RESEND] pwm: ftm: fix clock enable/disable when using PM
In-Reply-To: <564E6B6D.80006@mleia.com>
References: <1445142552-3530-1-git-send-email-stefan@agner.ch>
 <290ed017061ef41e1fe5c3fd5a523511@agner.ch>
 <564E6B6D.80006@mleia.com>
Message-ID: <20151123094955.GA31868@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 02:38:05AM +0200, Vladimir Zapolskiy wrote:
> On 19.11.2015 04:04, Stefan Agner wrote:
> > Thierry,
> > 
> > I realized that this patch did not make it into 4.4-rc1, while others,
> > IMHO less important patches which have been posted later (e.g. sunxi
> > whitespace fixes) have made it! :-(
> > 
> > Anything wrong with that? Or am I on your spam list? Note that this is
> > already a RESEND :-)
> 
> You are not alone with this problem, I have unreviewed changes in
> linux-pwm mailing list sent in 2014 :)

Please either ping me or resend patches if I don't reply within a week
or so. Chances are I've either not seen them or meant to reply but never
got around to.

Also, the Linux kernel is a community-driven project, so I fully expect
contributors to review each other's patches. Review isn't something that
only maintainers need to do.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151123/14831a96/attachment.sig>
