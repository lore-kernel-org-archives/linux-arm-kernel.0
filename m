From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 6 Jan 2016 22:01:17 +0100
Subject: [PATCH] ARM: dts: sun4i: Use red1 LED for heartbeat indication
 on Marsboard A10
In-Reply-To: <20151229165819.a4c0e978aa5ebd121113cad1@gmail.com>
References: <1451123879-7212-1-git-send-email-mamlinav@gmail.com>
 <20151227205151.GK30359@lukather>
 <20151229165819.a4c0e978aa5ebd121113cad1@gmail.com>
Message-ID: <20160106210117.GA9631@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 29, 2015 at 04:58:19PM +0300, Aleksei Mamlin wrote:
> On Sun, 27 Dec 2015 21:51:51 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > On Sat, Dec 26, 2015 at 12:57:59PM +0300, Aleksei Mamlin wrote:
> > > Marsboard A10 have four red LEDs, the first one can be used for
> > > heartbeat indication.
> > > 
> > > Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> > 
> > I'm really not sure about this one.
> > 
> > This is something that can easily be changed through sysfs, and it
> > will likely end up being a "war" on what trigger people want to use.
> > 
> 
> If so, then Ok, please ignore this patch.
> 
> Is there any way to set led triggers through cmdline instead of sysfs?

Unfortunately, I don't think there's any.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160106/f7c16428/attachment-0001.sig>
