From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 15 Oct 2014 15:37:47 +0200
Subject: [GIT PULL 2/2] Samsung defconfig updates for v3.18
In-Reply-To: <CAOesGMgRBq93diDmA-21UYkFQTZu+LiF9gV+A==GS5uGW9n-Vg@mail.gmail.com>
References: <543DB158.7030303@samsung.com>
 <CAOesGMgRBq93diDmA-21UYkFQTZu+LiF9gV+A==GS5uGW9n-Vg@mail.gmail.com>
Message-ID: <1413380267.4565.1.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-10-14 at 23:32 -0700, Olof Johansson wrote:
> On Tue, Oct 14, 2014 at 4:27 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> > tags/samsung-defconfig
> >
> > for you to fetch changes up to 508423bebcda29eb0ba7c627f895387dad7cdcd6:
> >
> >   ARM: exynos_defconfig: enable USB gadget support (2014-09-25 18:20:18
> > +0900)
> 
> Merged, thanks.

Hrm, enabling USB gadget support will actually regress USB on Exynos
peach boards and Arndale Octa without some of the DT fixes that landed
in armsoc next/late branch. Specifically:

5c42acdbffff9bab595482b966b22ab5e2f6f359 
dbb62ef9ade6e92737d3fac199665b8b7c455959

Might be good to cherry-pick those into for-next at this point (they're
rather trivial)

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141015/83e7551f/attachment.bin>
