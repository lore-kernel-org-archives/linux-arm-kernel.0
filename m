From: horms@verge.net.au (Simon Horman)
Date: Thu, 24 Apr 2014 10:00:19 +0900
Subject: [PATCH 22/33] ARM: shmobile: Use r8a7740 suffix for i2c, mmcif,
 fsi2 compat strings
In-Reply-To: <CAL_JsqKOi-mQ=xDDyP72RB1kN3_Ak114kMrbntsizxEehwVXuQ@mail.gmail.com>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
 <5c53f50c50badff499568a703467c3c9f23f9bfd.1398216022.git.horms+renesas@verge.net.au>
 <CAL_JsqKOi-mQ=xDDyP72RB1kN3_Ak114kMrbntsizxEehwVXuQ@mail.gmail.com>
Message-ID: <20140424010019.GC5064@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 08:12:50AM -0500, Rob Herring wrote:
> On Tue, Apr 22, 2014 at 8:25 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Ulrich Hecht <ulrich.hecht@gmail.com>
> >
> > Add "renesas,*-r8a7740" to the compatible strings for consistency with other
> > devices.
> 
> Generally, it is <vendor>,<chip>-<device> as the preferred ordering
> which is also consistent with your more generic name.

I believe that the naming used by this patch is consistent
with the naming used by other shmobile-related bindings.

In particular, the scheme that has been adopted for
hardware where we do not have documented version (numbers) is:

<vendor>,<ip>-<version>

Where the SoC name as a version.


My understanding is that Olof is comfortable with this as per our discussion
of this topic last August: "[GIT 00/19 v2] Renesas ARM based SoC pinmux"
