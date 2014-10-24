From: srv_yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Fri, 24 Oct 2014 21:53:34 +0800
Subject: [PATCH 6/7] arm: mediatek: enable gpt6 on boot up to make arch
 timer working
In-Reply-To: <CABuKBeJOgkDZ8drPf3LnT2jPH7PEWX2__HDM7_jZbg2BhDRy3g@mail.gmail.com>
References: <1406824943-24052-1-git-send-email-matthias.bgg@gmail.com>
 <1406824943-24052-7-git-send-email-matthias.bgg@gmail.com>
 <CACRpkdbRhGE8tcKj+W_4F9-xmcm-fxcYuCmLOqX-ESC+3PAmyA@mail.gmail.com>
 <CABuKBe+Q3tnN0s22EMY-dK_6FeN_xN9SmrsW3dPONR6QDJ+V_w@mail.gmail.com>
 <CACRpkdZOB=9wQ3R3sfcBEiNXLVRtgob4iLZ9QWXyVrgjqyvGXQ@mail.gmail.com>
 <CABuKBeJOgkDZ8drPf3LnT2jPH7PEWX2__HDM7_jZbg2BhDRy3g@mail.gmail.com>
Message-ID: <1414158814.14830.610.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Matthias,

I didn't saw this in v3.18-rc1, are you working on version 2 of this?
mt8135 and m8127 also need this fixup and we need this to have SMP
working.

Joe.C
