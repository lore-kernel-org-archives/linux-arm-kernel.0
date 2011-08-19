From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 19 Aug 2011 11:26:04 +0200
Subject: [PATCH 0/5] Miscellaneous s3c64xx fixes.
In-Reply-To: <000a01cc5e30$3a8508e0$af8f1aa0$%kim@samsung.com>
References: <5661373.tZL1ZnPyVO@flatron> <2042356.rlHOh83GOI@flatron>
	<000a01cc5e30$3a8508e0$af8f1aa0$%kim@samsung.com>
Message-ID: <1330481.xT3Tj51BQ9@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 19 of August 2011 at 14:24:09, Kukjin Kim wrote:
> Tomasz Figa wrote:
> > 
> > On Saturday 13 of August 2011 at 13:15:36, Kukjin Kim wrote:
> > > Tomasz Figa wrote:
> > > >
> > > > Anyone?
> > > >
> > > Hi Tomasz Figa,
> > >
> > > Will be on this in the next week...
> > >
> > > Thanks.
> > >
> > > Best regards,
> > > Kgene.
> > > --
> > > Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> > > SW Solution Development Team, Samsung Electronics Co., Ltd.
> > >
> > 
> > Thanks a lot. I have plenty of other S3C64xx patches to be submitted, but
> they
> > are more feature additions not fixes, so I am waiting for these fixes to
> be
> > reviewed first.
> > 
> Hi,
> 
> Firstly, you have to re-submit whole series with your 'sign'. It is very
> important.

Yes, I know, sorry for this. I must have missed a switch of git format-patch.
I will resend all the patches (excluding the dropped one).

> And 2nd, 3rd and 4th patches look ok to me except missing your sign even
> though I think, secure DMA mode should be setting in boot loader with trust
> zone...

I agree, that ideally this should be done by a boot loader, but since we don't
support Secure DMA at the moment, all the peripherals have to be forced into
normal insecure operation for the drivers using DMA to work correctly.

> Please refer to my review on 5th patch.

Done. I will address all your comments.

> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 

Best regards,
Tom
