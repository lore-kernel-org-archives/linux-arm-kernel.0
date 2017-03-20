From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Mar 2017 16:30:47 +0000
Subject: [PATCH v3 5/5] ARM: dts: sun8i: Update audio-routing with
 renamed widgets
In-Reply-To: <CAGb2v66ZLeoSQt0y2QVcDEBujS7JLQAptDq1WL8f8rkwSni6uw@mail.gmail.com>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-6-mylene.josserand@free-electrons.com>
 <20170320113817.rcphcvrizi4yphhe@sirena.org.uk>
 <CAGb2v66ZLeoSQt0y2QVcDEBujS7JLQAptDq1WL8f8rkwSni6uw@mail.gmail.com>
Message-ID: <20170320163047.3xizwkq6pogi73gp@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 07:53:37PM +0800, Chen-Yu Tsai wrote:
> On Mon, Mar 20, 2017 at 7:38 PM, Mark Brown <broonie@kernel.org> wrote:

> > Given that these are fixes it probably makes sense that they all go in
> > together, can I get some acks for this and I'll apply it?

> Acked-by: Chen-Yu Tsai <wens@csie.org>

> Though this patch should go in through the arm-soc tree.

Well, ideally but I'm not sure it's a super big deal to get the odd bit
coming through so long as it doesn't conflict, it's more of a big deal
to make sure that we don't get the ASoC side without the DT side and
vice versa.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/910a3028/attachment.sig>
