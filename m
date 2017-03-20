From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 20 Mar 2017 15:43:05 +0800
Subject: [PATCH v6 5/8] dt-bindings: input: touchscreen: Add max11801-ts
 binding
In-Reply-To: <CAMty3ZC=mS6L8ajEnZDPJsvMvOH0NF5MBHdc+MYofBXBfe9JXg@mail.gmail.com>
References: <1489647939-4966-1-git-send-email-jagan@openedev.com>
 <20170320023622.GA3443@dragon>
 <CAMty3ZC=mS6L8ajEnZDPJsvMvOH0NF5MBHdc+MYofBXBfe9JXg@mail.gmail.com>
Message-ID: <20170320074303.GF3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 11:55:27AM +0530, Jagan Teki wrote:
> >> @@ -0,0 +1,18 @@
> >> +* MAXI MAX11801 Resistive touch screen controller with i2c interface
> >> +
> >> +Required properties:
> >> +- compatible: must be "max11801"
> >
> > Shouldn't it have a vendor prefix?
> 
> Drivers i2c_device_id.name doesn't have vendor prefix, should I fix
> that one as well?

No.  The vendor prefix is only needed for device tree compatible.

Shawn
