From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 May 2014 19:18:55 +0100
Subject: [PATCH 1/3] arm64: Enable OPP
In-Reply-To: <CAGo_u6oL06G7jk8_X-SH73oWCAHX5vTj7ViC1AyaDhDLJEvWmw@mail.gmail.com>
References: <1399653631-4938-1-git-send-email-broonie@kernel.org>
 <CAGo_u6rGEWwywQ5JKh1ROhkOjrkWrM35PdWAooed26oak=1irA@mail.gmail.com>
 <20140509171120.GS12304@sirena.org.uk>
 <CAGo_u6oL06G7jk8_X-SH73oWCAHX5vTj7ViC1AyaDhDLJEvWmw@mail.gmail.com>
Message-ID: <20140509181855.GW12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 12:17:23PM -0500, menon.nishanth at gmail.com wrote:
> On Fri, May 9, 2014 at 12:11 PM, Mark Brown <broonie@kernel.org> wrote:

> > That's for the user visible symbol but OPP is also enableable via select
> > - the fix here may be to remove both the visibility check and the
> > dependency.

> That is reasonable.

OK, I've sent a patch - now I look at what the OPP stuff is doing that
definitely seems like a better approach.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/f08e7fb9/attachment.sig>
