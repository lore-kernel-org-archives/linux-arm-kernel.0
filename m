From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Dec 2014 11:38:32 +0000
Subject: [RFC 02/15] drivers/base: add restrack framework
In-Reply-To: <548E9BB9.806@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
 <1418226513-14105-3-git-send-email-a.hajda@samsung.com>
 <20141212165230.GP11764@sirena.org.uk> <548E9BB9.806@samsung.com>
Message-ID: <20141215113832.GX11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 09:28:41AM +0100, Andrzej Hajda wrote:
> On 12/12/2014 05:52 PM, Mark Brown wrote:
> > On Wed, Dec 10, 2014 at 04:48:20PM +0100, Andrzej Hajda wrote:

> > I don't know about anyone else but I'm having a hard time reading the
> > restrack name, it looks like a misspelling of restack to me.

> Any alternative names?

Well, even just res_track would help.

> I will move the code for provider matching to frameworks,
> so it will be easy to add just dev_info after every failed attempt
> of getting resource, including deferring. This is the simplest solution
> and it should be similar in verbosity to deferred probing.

> Maybe other solution is to provide debug_fs (or device) attribute showing
> restrack status per device.

I think both are useful - it's often helpful to have a listing of what
resources have actually been registered, for example to help spot typos.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141215/1bebb5ca/attachment.sig>
