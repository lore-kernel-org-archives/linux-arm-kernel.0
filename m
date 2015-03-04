From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 Mar 2015 17:13:17 +0100
Subject: [PATCH v2 3/3] ARM: mvebu: armada-385-ap: Enable USB3 port
In-Reply-To: <54F5DD7C.1050804@linux.intel.com>
References: <1421672474-2945-1-git-send-email-maxime.ripard@free-electrons.com>
 <1421672474-2945-4-git-send-email-maxime.ripard@free-electrons.com>
 <54F4B8B9.4010204@free-electrons.com>
 <20150303095924.GF4911@lukather> <54F5DD7C.1050804@linux.intel.com>
Message-ID: <20150304161317.GM4911@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Tue, Mar 03, 2015 at 06:12:44PM +0200, Mathias Nyman wrote:
> On 03.03.2015 11:59, Maxime Ripard wrote:
> > On Mon, Mar 02, 2015 at 08:23:37PM +0100, Gregory CLEMENT wrote:
> >> Hi Maxime,
> >>
> >> On 19/01/2015 14:01, Maxime Ripard wrote:
> >>> The Armada 385 AP board has a USB3 port exposed that uses a GPIO to drive the
> >>> VBUS line. Enable the needed drivers to support this.
> >>>
> >>
> >> it seems that this patch was not applied yet. Patch 1 is now in
> >> linux-next and should be part of 4.0-rc. But what about patch 2?
> > 
> > IIRC, Greg or Matthias said that Matthias would look into these
> > patches after the merge window.
> > 
> > It still didn't happen though.
> > 
> > Maxime
> > 
> 
> Hi
> 
> I understood that you wanted the first fix patch in as soon as possible so 
> I sent it forward to Greg, and it's now in his usb-linus branch.

Ah, so you were talking only about the first patch. My bad.

> The other two patches, 2/3 and 3/3 you said were "regual" patches
> (for usb-next?),

Indeed, at least for patch 2.

> Andrew said he can take 3/3 and wondered if 2/3 and 3/3 need to go
> together?

Patch 3 doesn't need to be merged through the same tree, so I guess
it's totally fine if 2 goes through USB and 3 through arm-soc.

> It doesn't matter for me, I can take 2/3 if you like, but I'd prefer if someone
> with more USB PHY insight could ack it first.

ACK.

Thanks!
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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150304/13faaa7f/attachment.sig>
