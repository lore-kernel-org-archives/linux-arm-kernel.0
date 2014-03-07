From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 7 Mar 2014 13:08:13 +0800
Subject: [PATCH v2] i2c:at91: Add device tree property to set
 clock-frequency
In-Reply-To: <CAJjB1qKriEVAQyvMaYu_N+QWJ=dzTxK91Hi_OUM8h_4i78EvbA@mail.gmail.com>
References: <1393293045-31849-1-git-send-email-mark.roszko@gmail.com>
 <20140228110506.GF11192@ldesroches-Latitude-E6320>
 <CAJjB1qLXnO-Zkte3vg_X5ktXmj1=tG+p5BcLX9vbCgzyfg_rWA@mail.gmail.com>
 <4A1E236E-E048-4E37-AFE8-C0AC283B73D0@jcrosoft.com>
 <CAJjB1qKriEVAQyvMaYu_N+QWJ=dzTxK91Hi_OUM8h_4i78EvbA@mail.gmail.com>
Message-ID: <05EF9B59-7009-49D2-B57F-5612C39F1FF0@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 7, 2014, at 12:26 PM, Mark Roszko <mark.roszko@gmail.com> wrote:

> Unless I'm misunderstanding your reply, it doesn't need to be set on
> each i2c device. It's meant to be an option to override the currently
> hardcoded 100khz for all the at91 devices.

yes you do need to set it on each device

as in the DT you describe the hw you set the speed of each device and then the bus
based on the present device will use the appropriate one

Best Regards,
J.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
