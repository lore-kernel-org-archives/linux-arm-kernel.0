From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 12:34:19 +0100
Subject: [PATCH] ARM: Samsung: Make PM_GENERIC_DOMAINS config depend on
 CONFIG_PM
In-Reply-To: <CAJuYYwQgZqN6nguddjS6bjLhx_ZhUZ5AfcrSAKBa7Ft-Bn6wPQ@mail.gmail.com>
References: <1332843404-25476-1-git-send-email-thomas.ab@samsung.com>
 <20120328105122.GF3232@opensource.wolfsonmicro.com>
 <CAJuYYwQgZqN6nguddjS6bjLhx_ZhUZ5AfcrSAKBa7Ft-Bn6wPQ@mail.gmail.com>
Message-ID: <20120328113419.GM3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 28, 2012 at 04:51:32PM +0530, Thomas Abraham wrote:
> On 28 March 2012 16:21, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > What's the underlying issue here? ?This seems like something the PM core
> > should be dealing with gracefully...

> The PM_GENERIC_DOMAINS config option has dependency on CONFIG_PM
> option. When building with PM disabled, the following errors occur.

Right, this does seem like something which it'd be better to handle
more gracefully in the PM core.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/c0db5744/attachment.sig>
