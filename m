From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 May 2016 14:01:56 +0200
Subject: [PATCH 06/20] drm/sun4i: allow dclk to modify its parent rate
In-Reply-To: <CAGb2v65tiUt9FvmJ2RaZdXaAFEznKZZjycO+tZcP-4spOAjObQ@mail.gmail.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-7-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v65tiUt9FvmJ2RaZdXaAFEznKZZjycO+tZcP-4spOAjObQ@mail.gmail.com>
Message-ID: <20160525120156.GA9232@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2016 at 01:18:44AM +0800, Chen-Yu Tsai wrote:
> Hi,
> 
> On Mon, May 16, 2016 at 8:47 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The pixel clock being only a divider of its parent clock, depending on the
> > resolution, it's expected to change its parent rate. Add that flag so that
> > the clock framework knows it.
> 
> This should be squashed into the previous patch. Otherwise, the previous one
> doesn't really fix things, and probably makes things worse as it assumes the
> parent clock would be changed.

Merged the two patches and applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160525/d359e38d/attachment.sig>
