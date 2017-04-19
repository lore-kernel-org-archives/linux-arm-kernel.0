From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Apr 2017 08:52:06 +0200
Subject: [PATCH 3/3] ARM: sun8i: a83t: Rename pinmux setting names
In-Reply-To: <CAGb2v65is5iyzXYvJMF7QLWXBdMBpemEm2kmyTnytx7V30M7Og@mail.gmail.com>
References: <20170418042205.27894-1-wens@csie.org>
 <20170418042205.27894-4-wens@csie.org>
 <20170418090447.dcxinewczubf26b7@lukather>
 <CAGb2v65is5iyzXYvJMF7QLWXBdMBpemEm2kmyTnytx7V30M7Og@mail.gmail.com>
Message-ID: <20170419065206.k5cb5gym35iabcbr@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 05:16:53PM +0800, Chen-Yu Tsai wrote:
> On Tue, Apr 18, 2017 at 5:04 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Tue, Apr 18, 2017 at 12:22:05PM +0800, Chen-Yu Tsai wrote:
> >> The pinmux setting nodes all have an address element in their node
> >> names, however the pinctrl node does not have #address-cells.
> >>
> >> Rename the existing pinmux setting nodes and labels in sun8i-a83t.dtsi,
> >> dropping identifiers for functions that only have one possible setting,
> >> and using the pingroup name if the function is identically available on
> >> different pingroups.
> >>
> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >
> > Applied, and I really like the new names.
> >
> > Would you make the same patch for everyone?
> 
> I can. No guarantees on the schedule though.

Sure, I know this isn't really the most entertaining and fulfilling
patch to make ;)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170419/274bb57d/attachment.sig>
