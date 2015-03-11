From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 11 Mar 2015 13:00:43 +0000
Subject: [PATCH 0/2] of: fix handling of '/' in path options
In-Reply-To: <CAL_JsqK=cODtAgt5jRQ-ASPBVatUztjOwDcZ6vzOh9bDKMdSBA@mail.gmail.com>
References: <1425924225-22748-1-git-send-email-leif.lindholm@linaro.org>
 <CAL_JsqK=cODtAgt5jRQ-ASPBVatUztjOwDcZ6vzOh9bDKMdSBA@mail.gmail.com>
Message-ID: <20150311130043.GW4278@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 07:49:33AM -0500, Rob Herring wrote:
> On Mon, Mar 9, 2015 at 1:03 PM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> > Commit 7914a7c5651a ("of: support passing console options with
> > stdout-path") neglected to deal with '/'s appearing past the ':'
> > terminator.
> >
> > This mini-series fixes this oversight and adds the tests to prove it.
> >
> > Leif Lindholm (1):
> >   of: fix handling of '/' in options for of_find_node_by_path()
> >
> > Peter Hurley (1):
> >   of: unittest: Add options string testcase variants
> 
> Are there changes from the previous versions? I've already pulled those in.

No, just sent together as a series since I didn't realise you had.

/
    Leif
