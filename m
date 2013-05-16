From: broonie@kernel.org (Mark Brown)
Date: Thu, 16 May 2013 18:35:59 +0100
Subject: [alsa-devel] [PATCH] ASoC: dfbmcs320: make the driver common for
 other BT modules
In-Reply-To: <CAGsJ_4yn2uodRKrFKYrX85XA7A=hQs2w0cyGoEEHsYgCJHD7eQ@mail.gmail.com>
References: <1368687184-12169-1-git-send-email-Baohua.Song@csr.com>
 <5194AC3C.4080206@metafoo.de>
 <CAGsJ_4yoXj+e7A20SM5+ctLvE2QRTp0bzDeKfCZSUHTO8BPq5A@mail.gmail.com>
 <5194C2FC.70804@metafoo.de>
 <CAGsJ_4yn2uodRKrFKYrX85XA7A=hQs2w0cyGoEEHsYgCJHD7eQ@mail.gmail.com>
Message-ID: <20130516173559.GD1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 08:00:17PM +0800, Barry Song wrote:

> i did think it is a good idea to have device id list while i sent the
> last mail. and it matches with the generic device driver engineering
> sense. the problem is i don't how long the list will be.
> if you like to keep dfbmcs320 at least for the moment, i would agree.

I'd prefer to see the ID list; we shouldn't be throwing away
information.  Probably we can go a long way towards cutting down the
length of the list if it gets silly with use of wildcards in the device
names listed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130516/b49bd1d4/attachment.sig>
