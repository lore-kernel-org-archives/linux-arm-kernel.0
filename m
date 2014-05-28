From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 28 May 2014 09:34:33 +0300
Subject: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
In-Reply-To: <20140527205910.GE32336@atomide.com>
References: <1398815562-24113-5-git-send-email-tony@atomide.com>
 <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com>
 <20140430174751.GA12362@atomide.com> <20140505183919.GA15463@atomide.com>
 <20140508233628.GJ2198@atomide.com> <536C7EA7.5000306@ti.com>
 <20140509153723.GD17814@atomide.com> <20140513213205.GB18001@atomide.com>
 <537C9FC6.8020104@ti.com> <20140521145053.GG17417@atomide.com>
 <20140527205910.GE32336@atomide.com>
Message-ID: <53858379.4050401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/05/14 23:59, Tony Lindgren wrote:

> In case you did not yet do it, here's this patch updated for you. I'm
> assuming you'll apply this to your panel dts branch. Let me know when the
> dependencies are in linux next and I'll test it one more time. The omap
> changes finally hit linux next as of today, so I'm only doing fixes
> and minimal changes for now.

I haven't pushed the dts changes to linux-next as the base branch was
missing. Now that it's there, I have pushed the DSS dts changes also.

You can do a manual merge if you want to try before linux-next is updated:

git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git for-next

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/a43f6a89/attachment-0001.sig>
