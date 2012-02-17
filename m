From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 17 Feb 2012 15:56:37 +0530
Subject: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
In-Reply-To: <4F3E2984.6000201@ti.com>
References: <20120215182355.18884.18682.stgit@kaulin.local>
 <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com>
 <20120216121234.GJ15338@n2100.arm.linux.org.uk> <4F3CF7D1.8050807@ti.com>
 <4F3D0186.2010500@ti.com> <20120216135151.GK15338@n2100.arm.linux.org.uk>
 <20120217091433.GL15338@n2100.arm.linux.org.uk> <4F3E1ED5.6090305@ti.com>
 <4F3E251B.6040404@ti.com> <20120217100632.GM15338@n2100.arm.linux.org.uk>
 <4F3E2984.6000201@ti.com>
Message-ID: <4F3E2B5D.6040601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 February 2012 03:48 PM, Rajendra Nayak wrote:
>>
>
> Yes, I did get a WARN saying the device is already registered. An
> unregister in my teardown should fix that too.

And now I see there is no way to unregister an omap_device :-)
which needs to be added.
