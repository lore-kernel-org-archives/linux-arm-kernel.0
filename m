From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Oct 2016 19:26:47 +0200
Subject: [PATCH v4 3/9] clk: sunxi-ng: Finish to convert to structures
 for arguments
In-Reply-To: <CAGb2v67CWEEcC+AQ9MqsyKokTx2ZVXKqBSUFW_x7CfjHrL_JFA@mail.gmail.com>
References: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
 <67333887b86b7fd838dd9d6523dc7e3d9a9ddeb4.1476196031.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67CWEEcC+AQ9MqsyKokTx2ZVXKqBSUFW_x7CfjHrL_JFA@mail.gmail.com>
Message-ID: <20161020172647.ngib3vf3dteoo4xn@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 10:35:18PM +0800, Chen-Yu Tsai wrote:
> On Tue, Oct 11, 2016 at 10:28 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Some clocks still use an explicit list of arguments, which make it a bit
> > more tedious to add new parameters.
> >
> > Convert those over to a structure pointer argument to add as many
> > arguments as possible without having to many noise in our patches, or a
> > very long list of arguments.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161020/de349263/attachment.sig>
