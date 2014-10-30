From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 30 Oct 2014 11:23:20 +0800
Subject: [PATCH 6/7] arm: mediatek: enable gpt6 on boot up to make arch
 timer working
In-Reply-To: <CABuKBe++mqhMCPxci9_4KKgq9vdoLLwZQkdb2xAGMud+=YVhkw@mail.gmail.com>
References: <1406824943-24052-1-git-send-email-matthias.bgg@gmail.com>
 <1406824943-24052-7-git-send-email-matthias.bgg@gmail.com>
 <CACRpkdbRhGE8tcKj+W_4F9-xmcm-fxcYuCmLOqX-ESC+3PAmyA@mail.gmail.com>
 <CABuKBe+Q3tnN0s22EMY-dK_6FeN_xN9SmrsW3dPONR6QDJ+V_w@mail.gmail.com>
 <CACRpkdZOB=9wQ3R3sfcBEiNXLVRtgob4iLZ9QWXyVrgjqyvGXQ@mail.gmail.com>
 <CABuKBeJOgkDZ8drPf3LnT2jPH7PEWX2__HDM7_jZbg2BhDRy3g@mail.gmail.com>
 <1414158814.14830.610.camel@mtksdaap41>
 <CABuKBe++mqhMCPxci9_4KKgq9vdoLLwZQkdb2xAGMud+=YVhkw@mail.gmail.com>
Message-ID: <1414639400.5833.11.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Mon, 2014-10-27 at 11:28 +0100, Matthias Brugger wrote:
> Hi Joe,
> 
> 2014-10-24 15:53 GMT+02:00 Yingjoe Chen <srv_yingjoe.chen@mediatek.com>:
> >
> > Hi Matthias,
> >
> > I didn't saw this in v3.18-rc1, are you working on version 2 of this?
> > mt8135 and m8127 also need this fixup and we need this to have SMP
> > working.
> 
> I had a discussion with Mark Rutland from ARM on this [0].
> At that point he convinced me that this was not critical.
> 
> If we need this for SMP, things really change here I think.

We have some driver now, and we started to implement SMP enable method
internally. I think it is reasonable to discuss this now.
We could include this patch in our SMP patch series. Do you prefer we do
this?

Joe.C
