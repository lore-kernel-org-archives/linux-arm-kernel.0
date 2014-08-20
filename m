From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Aug 2014 16:32:02 +0200
Subject: [PATCH v2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <CAOesGMhBdQh_ddycZ-Y5dupR9hW74bogHtG3yyPUJ2tAgWi19A@mail.gmail.com>
References: <1407957267-3258-1-git-send-email-dgreid@chromium.org>
 <53EF76CF.9050808@suse.de> <53F2255E.7090208@wwwdotorg.org>
 <CAL1qeaH-WfA-DLKwuXA_hBPHYuXksAibLq__zisrT9ALaRGdAw@mail.gmail.com>
 <53F28F90.3000004@wwwdotorg.org>
 <CAOesGMhBdQh_ddycZ-Y5dupR9hW74bogHtG3yyPUJ2tAgWi19A@mail.gmail.com>
Message-ID: <20140820143201.GA3368@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 20, 2014 at 06:29:14AM -0700, Olof Johansson wrote:
> On Mon, Aug 18, 2014 at 4:43 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
[...]
> > Again, this board *isn't* Nyan, so it should pretend that it is.
> 
> It is a derivative design of the nyan reference platform, and it is
> compatible with it. It is perfectly fine to claim to be compatible
> with it. I'm sorry, but you're just wrong here.

I guess that depends a little on how you define compatibility. I had
always assumed that the top-level compatible string would be a sort of
"checksum" over the rest of the content. Which, admittedly, makes it
kind of redundant. Compatibility could mean a lot of things. Does it
mean any kernel/DTB compatible with one device could run on any device
derived from it? Does compatibility mean it needs to provide full
functionality or is it still compatible if it runs at a reduced feature
set but doesn't "break" otherwise?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/882f6571/attachment.sig>
