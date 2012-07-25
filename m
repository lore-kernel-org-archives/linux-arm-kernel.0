From: balbi@ti.com (Felipe Balbi)
Date: Wed, 25 Jul 2012 14:15:27 +0300
Subject: [PATCH v4 1/4] ARM: OMAP4: Remove un-used control module headers
 and defines.
In-Reply-To: <500FD5DC.7010002@dev.rtsoft.ru>
References: <500FD2E9.8050408@dev.rtsoft.ru>
 <20120725110635.GE16794@arwen.pp.htv.fi>
 <500FD5DC.7010002@dev.rtsoft.ru>
Message-ID: <20120725111526.GI16794@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 25, 2012 at 03:17:48PM +0400, Konstantin Baydarov wrote:
>   Hi, Balbi.
> 
> On 07/25/2012 03:06 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Wed, Jul 25, 2012 at 03:05:13PM +0400, Konstantin Baydarov wrote:
> >> Most of the OMAP4 control module register defines are not used and
> >> can be removed. Keep only needed defines and move them to common
> >> control module header just like other OMAP versions.
> >>
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> >> Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
> > Wasn't this one authored by Santosh ?? Where's his From: Santosh
> > Shilimkar ???
> 
> I hit "edit as new" when I sent patches through thunderbird, I'll fix in the next series.

git send-email would help avoiding those ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120725/629fcf65/attachment.sig>
