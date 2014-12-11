From: broonie@kernel.org (Mark Brown)
Date: Thu, 11 Dec 2014 12:58:37 +0000
Subject: [RFC 04/15] regulator: add restrack support
In-Reply-To: <548976D2.7080005@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
 <1418226513-14105-5-git-send-email-a.hajda@samsung.com>
 <20141210160720.GS11764@sirena.org.uk>
 <548976D2.7080005@samsung.com>
Message-ID: <20141211125837.GV11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 11:49:54AM +0100, Andrzej Hajda wrote:
> On 12/10/2014 05:07 PM, Mark Brown wrote:
> > On Wed, Dec 10, 2014 at 04:48:22PM +0100, Andrzej Hajda wrote:

> >> Regulators supports various methods of lookup.
> >> The patch adds restrack support only to DT based regulators.

> > Why, what does this mean and how might one use it?  I've not looked at
> > the code since I don't know what it's supposed to accomplish...

> Looking at this patch makes no sense without looking at cover letter
> or at the patch adding restrack framework. In short adding restrack support
> to regulators will allow to:

I did look at the cover letter and glance at the first couple of patches
but I still can't tell what this is really intended to do.  There's a
lot of implementation detail but not a lot of high level overview so
it's not very clear to me how exactly this solves problems or how it is
different to the component framework, it sounds very similar.

I'd expect someone reading the change in the regulator API to have at
least some idea how this fits in with the rest of the API and how to use
it, and probably more importantly I'd expect to be able to understand
why this is DT only.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141211/26ed42f8/attachment-0001.sig>
