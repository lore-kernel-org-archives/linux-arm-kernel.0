From: broonie@kernel.org (Mark Brown)
Date: Fri, 26 Jul 2013 11:55:19 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <CAL_JsqJQWOLC9f1igEpsgJB2X8mFDpqLDaFFRjGGVHctjWZLgQ@mail.gmail.com>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <CAL_JsqJQWOLC9f1igEpsgJB2X8mFDpqLDaFFRjGGVHctjWZLgQ@mail.gmail.com>
Message-ID: <20130726105519.GZ9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 02:11:31PM -0500, Rob Herring wrote:

> I would argue that little has gone in (if reviewed) with the
> expectation that the binding will change. Many of the common bindings
> have had many rounds of review and they have not changed. My position
> any time I see an incompatible change has been that it require anyone
> affected to be okay with the change. This has pretty much been limited
> to specific platforms from what I've seen.

The big exception I've seen has been the OMAP hwmod stuff.  Plus of
course the case where things get moved into the DT bindings from the
board file as things are built up, but this should be becoming a non
issue as people move onto DT only boards (though I am worried about
people on systems where the SoC is described in DT).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/b7ddc32a/attachment-0001.sig>
