From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 12 Apr 2013 09:25:39 +0300
Subject: [PATCH] video: mxsfb: Adapt to new videomode API
In-Reply-To: <20130412020202.GC16970@S2101-09.ap.freescale.net>
References: <1365516978-29888-1-git-send-email-fabio.estevam@freescale.com>
 <5165228F.1020805@ti.com>
 <CAOMZO5BY0mpYC1sjkRsnX-jnj8X4u9ZH15GCQ=MqMYeQ-LAfuQ@mail.gmail.com>
 <20130412020202.GC16970@S2101-09.ap.freescale.net>
Message-ID: <5167A8E3.7070109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-04-12 05:02, Shawn Guo wrote:
> On Wed, Apr 10, 2013 at 09:36:31AM -0300, Fabio Estevam wrote:
>> On Wed, Apr 10, 2013 at 5:27 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>
>>> The mxsfb.c driver in my tree does not contain such code. Where is this
>>> patch meant to be applied?
>>
>> linux-next 20130408 is broken for mxs without this fix. Maybe Shawn can take it?
> 
> I will take it and send it during -rc when Tomi's patches hit mainline.
> But I have a couple trivial comments on the patch.  I'm replying to the
> patch.

Fine by me, but wouldn't it be easier to get the mxsfb driver changes
along with other fbdev changes via my tree? Or do you have dependencies
to arch changes or such in the mxsfb changes?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 899 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130412/1a249917/attachment.sig>
