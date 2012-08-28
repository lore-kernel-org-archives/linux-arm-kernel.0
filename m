From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 28 Aug 2012 11:35:17 +0200
Subject: [PATCH] media: mx2_camera: Remove MX2_CAMERA_SWAP16 and
 MX2_CAMERA_PACK_DIR_MSB flags.
In-Reply-To: <CACKLOr3OmRUACO8QaJnYA6E=YZMCrrOq1pAXb1wTv4Udg+u8bQ@mail.gmail.com>
References: <1342083809-19921-1-git-send-email-javier.martin@vista-silicon.com>
 <Pine.LNX.4.64.1207201330240.27906@axis700.grange>
 <CACKLOr2sKVWCk3we_cP5MvnR6-WsaFwA9AC=fgp3iLm8B6mfEA@mail.gmail.com>
 <Pine.LNX.4.64.1207301718510.28003@axis700.grange>
 <CACKLOr3OmRUACO8QaJnYA6E=YZMCrrOq1pAXb1wTv4Udg+u8bQ@mail.gmail.com>
Message-ID: <20120828093517.GH26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 10:08:39AM +0200, javier Martin wrote:
> Hi,
> 
> On 30 July 2012 17:33, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > Hi Javier
> >
> > On Mon, 30 Jul 2012, javier Martin wrote:
> >
> >> Hi,
> >> thank you for yor ACKs.
> >>
> >> On 20 July 2012 13:31, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> >> > On Thu, 12 Jul 2012, Javier Martin wrote:
> >> >
> >> >> These flags are not used any longer and can be safely removed
> >> >> since the following patch:
> >> >> http://www.spinics.net/lists/linux-media/msg50165.html
> >> >>
> >> >> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> >> >
> >> > For the ARM tree:
> >> >
> >> > Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >>
> >> forgive my ignorance on the matter. Could you please point me to the
> >> git repository this patch should be merged?
> >
> > Sorry, my "for the ARM tree" comment was probably not clear enough. This
> > patch should certainly go via the ARM (SoC) tree, since it only touches
> > arch/arm. So, the maintainer (Sascha - added to CC), that will be
> > forwarding this patch to Linus can thereby add my "acked-by" to this
> > patch, if he feels like it.
> >
> 
> Sascha, do you have any comments on this one? I can't find it in
> arm-soc, did you already merge it?

Applied, thanks. I have rewritten the commit message as follows:

Author: Javier Martin <javier.martin@vista-silicon.com>
Date:   Thu Jul 12 11:03:29 2012 +0200

    ARM i.MX mx2_camera: Remove MX2_CAMERA_SWAP16 and MX2_CAMERA_PACK_DIR_MSB flags.
    
    These flags are not used any longer and can be safely removed
    since:
    
    | commit 8a76e5383fb5f58868fdd3a2fe1f4b95988f10a8
    | Author: Javier Martin <javier.martin@vista-silicon.com>
    | Date:   Wed Jul 11 17:34:54 2012 +0200
    |
    |    media: mx2_camera: Fix mbus format handling
    
    Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
    Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
    Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
