From: felipe.balbi@nokia.com (Felipe Balbi)
Date: Tue, 25 May 2010 08:49:47 +0300
Subject: [PATCH v3 14/14] omap: mailbox: reorganize headers
In-Reply-To: <AANLkTimEtI3pDJKJOCyiBK8f0y1p0nyyIeptcS2eyy_v@mail.gmail.com>
References: <1274548465-20208-1-git-send-email-felipe.contreras@gmail.com>
	<1274548465-20208-15-git-send-email-felipe.contreras@gmail.com>
	<20100524171634.GA23202@nokia.com>
	<AANLkTimEtI3pDJKJOCyiBK8f0y1p0nyyIeptcS2eyy_v@mail.gmail.com>
Message-ID: <20100525054947.GA26007@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 24, 2010 at 09:14:24PM +0200, ext Felipe Contreras wrote:
>Now, regarding device.h:

which was my only concern

>Now, I am pretty sure that platform_device.h will always depend on
>device.h that's why I removed them, but I can add them again if
>somebody wants to, but again, the situation is already bad.

so there's platform_device.h on that file, a little comment on the 
changelog would suffice to avoid this kind of mis-understanding.

-- 
balbi

DefectiveByDesign.org
