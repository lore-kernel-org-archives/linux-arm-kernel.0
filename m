From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 17 Nov 2016 08:50:11 -0300
Subject: [PATCH 0/3] thermal: Fix module autoload for drivers
In-Reply-To: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
References: <1476455702-21748-1-git-send-email-javier@osg.samsung.com>
Message-ID: <CABxcv==keE6X5B1R+DSaZewVDdpCtuGF5j4S46YF3pncHT8q2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eduardo,

On Fri, Oct 14, 2016 at 11:34 AM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello,
>
> This small series contains trivial fixes to allow modules to be autoloaded
> when its correspoinding thermal device is registered.
>
> Best regards,
> Javier
>
>
> Javier Martinez Canillas (3):
>   thermal: max77620: Fix module autoload
>   thermal: tango: Fix module autoload
>   thermal: db8500: Fix module autoload
>

Any comments about these patches?

Best regards,
Javier
