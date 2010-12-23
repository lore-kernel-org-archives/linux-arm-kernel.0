From: nm@ti.com (Nishanth Menon)
Date: Thu, 23 Dec 2010 12:06:32 -0600
Subject: [PATCH v5 4/5] OMAP4: hwmod: Add inital data for smartreflex
	modules.
In-Reply-To: <3f3f455d44f6ee5009a9ea387f35376c@mail.gmail.com>
References: <1292864437-15353-1-git-send-email-thara@ti.com>	<1292864437-15353-5-git-send-email-thara@ti.com>	<4D133B78.5030807@ti.com>	<a58103fd01d89decba08fcdf282b7f70@mail.gmail.com>
	<87d3osl8bl.fsf@deeprootsystems.com> <4D1385D6.6090407@ti.com>
	<3f3f455d44f6ee5009a9ea387f35376c@mail.gmail.com>
Message-ID: <4D138FA8.9030109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vishwanath Sripathy had written, on 12/23/2010 11:36 AM, the following:
[..]
>> Further, why is SR enabled by default on this platform if it does not
>> have all domains available to be enabled (e.x. we dont have it on
>> PandaBoard even though it is OMAP4 rt?)
> Why do you think SR is enabled by default? The above log says that SR
> Module is initialized. However sr auto compensation is not started by
> default.
oops.. my bad. Apologies, I missed that this is part of probe path not 
part of sr_classX_init path. looking at the code, I will refrain from 
commenting further on probe function at this point.

-- 
Regards,
Nishanth Menon
