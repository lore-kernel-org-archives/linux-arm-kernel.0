From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 03 Dec 2014 21:36:11 +0100
Subject: [PATCH] ARM: dts: Add dts file for odroid XU3 board
In-Reply-To: <7hzjb4y0gp.fsf@deeprootsystems.com>
References: <1417438770-28696-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <7hzjb4y0gp.fsf@deeprootsystems.com>
Message-ID: <1417638971.21830.42.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-12-03 at 11:53 -0800, Kevin Hilman wrote:
> Sjoerd Simons <sjoerd.simons@collabora.co.uk> writes:
> Tried this on top of linux-next (next-20141125 and next20141203) and
> boots fine on my odroid-xu3. 
> 
> Thanks for doing this, I've been meaning to get a DTS upstream for this
> platform myself.  I also noticed that the imprecise aborts I've been
> seeing when booting this board with the smdk5420 DTS are gone, so I
> don't have to dig into those now either.  Thanks!  :)

For completeness, the problem with running the smdk5420 DTS on the XU3
is that the XU3 runs secure firmware while the SMD5420 doesn't.. Hence
the imprecise aborts you were seeing.

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 6170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/311ef32f/attachment.bin>
