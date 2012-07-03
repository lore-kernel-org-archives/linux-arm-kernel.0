From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 3 Jul 2012 15:21:23 +0100
Subject: [PATCH 1/1] mfd: Fix runtime warning caused by duplicate device
 registration
In-Reply-To: <4FF2F82D.9080507@linaro.org>
References: <1341316788-12730-1-git-send-email-lee.jones@linaro.org>
 <20120703123552.GC25995@sirena.org.uk>
 <4FF2EEA1.6080204@linaro.org>
 <20120703132447.GN29030@opensource.wolfsonmicro.com>
 <4FF2F82D.9080507@linaro.org>
Message-ID: <20120703142123.GQ29030@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 02:48:29PM +0100, Lee Jones wrote:
> On 03/07/12 14:24, Mark Brown wrote:

> >I'm really unconvinced that instnatiating the MFD cells from device tree
> >is in general a good idea.

> Well it just doesn't work the other way.

In what way does it not work?

> >>See c5395e7ed8f16cc7bb72a783de68659db5aed515 for a short description
> >>of the troubles we faced.

> >$ git show c5395e7ed8f16cc7bb72a783de68659db5aed515
> >fatal: bad object c5395e7ed8f16cc7bb72a783de68659db5aed515

> Sorry, looks live I've rebased since.

> 5f3fc8adeec9bb12742fbfa777fa1947deda21a2

This doesn't explain any of the issues, it just says that they exist.
My best guess would be that at least some of the issue is due to
instantiating the MFD cells from the device tree but it's hard to say
clearly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120703/feaa42d3/attachment.sig>
