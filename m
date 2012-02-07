From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 7 Feb 2012 11:38:55 +0000
Subject: [PATCH v2 02/10] pwm: Allow chips to support multiple PWMs.
In-Reply-To: <20120207070400.GA29238@avionic-0098.mockup.avionic-design.de>
References: <1328541585-24642-1-git-send-email-thierry.reding@avionic-design.de>
 <1328541585-24642-3-git-send-email-thierry.reding@avionic-design.de>
 <4F3044A9.8000202@metafoo.de>
 <20120207070400.GA29238@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120207113854.GI3332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2012 at 08:04:00AM +0100, Thierry Reding wrote:
> * Lars-Peter Clausen wrote:

> > If we've learned one thing from gpiolib, I think it is that using a global
> > index to identify a resource was a bad idea.

> Yes, that concern has been raised several times already. The reason for it
> being this way is that the current API requires it. So either we keep it as

Might be worth calling this out in the changelog to preempt further
discussion - it's a totally sensible approach to take but it's not
going to be immediately obvious to reviewers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120207/75c22e28/attachment.sig>
