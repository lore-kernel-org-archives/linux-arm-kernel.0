From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Feb 2014 12:29:30 +0100
Subject: [PATCH 0/5] mv64xxx updates
In-Reply-To: <20140213215100.1d714c4b@skate>
References: <20140213094117.GA3934@katana>
 <1392323793-4125-1-git-send-email-wsa@the-dreams.de>
 <20140213215100.1d714c4b@skate>
Message-ID: <20140218112930.GE3142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 13, 2014 at 09:51:00PM +0100, Thomas Petazzoni wrote:
> Dear Wolfram Sang,
> 
> On Thu, 13 Feb 2014 21:36:28 +0100, Wolfram Sang wrote:
> > So, this is a series I came up with trying to fix the issue found by Kevin.
> > Patches 1+2 are hopefully fixing the bug (in theory, I don't have the HW).
> > Patches 3-5 are RFC, and if patch 3 actually works (see the CHECKME), then 4+5
> > are further cleanup possibilities. And there is still more potential, I mainly
> > wanted to give some inspiration and awareness that the driver could need some
> > more love. Please test at least 1+2, comments to 3-5 very welcome.
> > 
> > Sorry for the delay, I got distracted by an NMI.
> 
> I'm adding Maxime Ripard in Cc, since he is the maintainer of the
> Allwinner platform, which also uses this I2C driver. So I guess he
> would like to be notified of such changes in order to test that the
> driver still works for him.

I just gave a try to these patches, on my A31 board with the extra
patches sent previously.

Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/3a3f8b4c/attachment.sig>
