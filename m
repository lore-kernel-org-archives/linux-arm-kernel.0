From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Mon, 15 Aug 2016 17:10:47 +0800
Subject: [PATCH v3 0/9] Add MT8173 Video Decoder Driver
In-Reply-To: <74aa2d31-97dd-d274-e07d-b4532c0f4fa5@xs4all.nl>
References: <1464611363-14936-1-git-send-email-tiffany.lin@mediatek.com>
 <bdac7fe1-6425-2a3d-777f-86cfd1ee26e0@xs4all.nl>
 <1471251821.28498.7.camel@mtksdaap41>
 <74aa2d31-97dd-d274-e07d-b4532c0f4fa5@xs4all.nl>
Message-ID: <1471252247.28498.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,


On Mon, 2016-08-15 at 11:07 +0200, Hans Verkuil wrote:
> On 08/15/2016 11:03 AM, Tiffany Lin wrote:
> > Hi Hans,
> > 
> > I upstream v4 on 8/10, I don't know why this version is not shown in
> > https://patchwork.kernel.org.
> > But I could see it in other link.
> > http://www.spinics.net/lists/arm-kernel/msg523095.html
> > I refine DocBook and vb2 queue_setup function in v4.
> > 
> > For the MT21 format, if I put MT21 into separate patch, this patch
> > series will build fail, I was confused how to fix this issue?
> 
> Just don't implement that pixelformat yet. I.e. everything else can be
> implemented, just don't add MT21 to the list of pixelformats. Do that in
> a separate patch at the end.
> 
> If that pixelformat isn't exposed, then nobody will use it either :-)
> 
Got it now.
Thanks a lot.


best regards,
Tiffany

> Regards,
> 
> 	Hans
