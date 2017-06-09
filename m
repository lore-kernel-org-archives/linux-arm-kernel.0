From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 9 Jun 2017 23:38:43 +0200
Subject: [PATCH v8 14/34] ARM: dts: imx6-sabreauto: add the ADV7180 video
 decoder
In-Reply-To: <dd5b29b7-bf92-5f03-caef-1843a9f32cd3@gmail.com>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
 <1496860453-6282-15-git-send-email-steve_longerbeam@mentor.com>
 <CAJ+vNU0C0=4hUq+g1P7yTzLzFPidfauQROPOVr4WQWKNZz_xmQ@mail.gmail.com>
 <dd5b29b7-bf92-5f03-caef-1843a9f32cd3@gmail.com>
Message-ID: <20170609213843.GB28596@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2017-06-08 13:36:12, Steve Longerbeam wrote:
> 
> 
> On 06/08/2017 01:25 PM, Tim Harvey wrote:
> >
> >
> >Steve,
> >
> >You need to remove the fim node now that you've moved this to V4L2 controls.
> >
> 
> Yep, I caught this just after sending the v8 patchset. I'll send
> a v9 of this patch.

This needs ack from devicetree people, then it can be merged. Can you
be a bit more forceful getting the ack?

I don't think it makes sense to resubmit v9 before that. This is not a
rocket science.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/c0586c4b/attachment.sig>
