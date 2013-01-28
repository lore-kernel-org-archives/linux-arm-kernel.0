From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jan 2013 12:47:52 +0200
Subject: OMAP baseline test results for v3.8-rc5
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1301260838300.19277@utopia.booyaka.com>
 <20130126084604.GB8754@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9456A@DBDE01.ent.ti.com>
Message-ID: <20130128104752.GB28698@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 28, 2013 at 11:34:15AM +0100, Mohammed, Afzal wrote:
> Hi,
> 
> On Sat, Jan 26, 2013 at 14:16:04, Balbi, Felipe wrote:
> > On Sat, Jan 26, 2013 at 08:40:07AM +0000, Paul Walmsley wrote:
> 
> > > * am335xbone: hangs after "Starting kernel"
> > >   - Cause unknown; may be due to CONFIG_EARLY_PRINTK=y?
> > >   - http://www.mail-archive.com/linux-omap at vger.kernel.org/msg82297.html
> > >   - http://marc.info/?l=linux-omap&m=135903184512238&w=2
> > 
> > FYI, I don't think it's related to CONFIG_EARLY_PRINTK. Tested with and
> > without it, also removed CONFIG_DEBUG_LL completely and nothing seemed
> > to help my bone, no matter if I had appended DTB or not.
> 
> Following patch with low level debug may help to find where the issue is,
> (my observation is that it boots with mainline u-boot)

will try your patch, but are you using Beagle Bone white or black ? I
should've made it clear I'm using beagle bone black.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130128/1cb14c78/attachment.sig>
