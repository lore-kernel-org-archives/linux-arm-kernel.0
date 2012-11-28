From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 28 Nov 2012 14:20:05 +0100
Subject: [PATCH v8 2/2] usb: s3c-hsotg: Adding phy driver support
In-Reply-To: <CAD6zSYMNSX8ASPBLpft-0riBi-xeD_b=BjCjSrftX_5_F2+TDA@mail.gmail.com>
References: <1352888836-17192-1-git-send-email-p.paneri@samsung.com>
 <1433031.3ftjAfsj34@flatron>
 <CAD6zSYMNSX8ASPBLpft-0riBi-xeD_b=BjCjSrftX_5_F2+TDA@mail.gmail.com>
Message-ID: <4963449.bQgUShLPPx@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Praveen,

On Friday 23 of November 2012 09:54:51 Praveen Paneri wrote:
> We will anyway remove the platform data part soon. If you say I can
> resend it again.

I think that the requirement for platform data on DT-enabled systems 
should be removed before this series get merged, because there are already 
patches being worked on to remove auxdata tables (common clock framework 
support by Thomas Abraham).

Adding next auxdata entry (containing platform data that must be provided) 
would make them depend on phy platform data removal patch, which would 
complicate things.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
