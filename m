From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 6 Nov 2013 13:10:01 +0100
Subject: [PATCH] ARM: nommu: Implement dummy early_paging_init()
In-Reply-To: <CAOesGMg0Ah7HoDOiOX+dDYCA3A17-VryiULuUzT-j-BHFyCaOw@mail.gmail.com>
References: <1382533728-19495-1-git-send-email-treding@nvidia.com>
 <CAOesGMg0Ah7HoDOiOX+dDYCA3A17-VryiULuUzT-j-BHFyCaOw@mail.gmail.com>
Message-ID: <20131106121000.GA6984@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 11:47:13AM -0800, Olof Johansson wrote:
> On Wed, Oct 23, 2013 at 6:08 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > No-MMU configurations currenty fail to build because they are missing
> > the early_paging_init() symbol.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> This is still showing up on -next with at91x40_defconfig. Can you feed
> it to the patch tracker if you haven't already?

Done. I'm not sure exactly what the prerequisites are for submitting a
patch to the tracker. The help text on the website says patches should
be reviewed on the mailing list first and that's what I was waiting for.
Is there some amount of time (a week or two) after which silence can be
considered acknowledgement?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131106/545a44f4/attachment.sig>
