From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Fri, 3 Nov 2017 08:09:00 -0600
Subject: [PATCH 2/2] media: s5p-mfc: fix lock confection -
 request_firmware() once and keep state
In-Reply-To: <CAM3PiRxjO-sP22v5ZSRvKUCwn7B8S_G_GVWW_Uk75aZd3CsoMQ@mail.gmail.com>
References: <cover.1507325072.git.shuahkh@osg.samsung.com>
 <CGME20171006213016epcas3p20e34abea60ca43f7c3f79a68fc7a38d7@epcas3p2.samsung.com>
 <fab205fc9ba1bc00e5dda4db6d426fde69116c37.1507325072.git.shuahkh@osg.samsung.com>
 <c1704d1b-95e8-e6a2-9086-3079f78daa00@samsung.com>
 <93d0668e-1fa6-ac2b-d998-9e0317469dd1@osg.samsung.com>
 <CAM3PiRxjO-sP22v5ZSRvKUCwn7B8S_G_GVWW_Uk75aZd3CsoMQ@mail.gmail.com>
Message-ID: <f7839fdb-42e5-489d-26be-e3b1b9610aff@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2017 06:43 PM, Marian Mihailescu wrote:
> I can confirm, with this patch, there is always error loading MFC in
> boot log, since FS is not mounted.
> 
> -Marian
> 

Please refrain from top posting to a kernel email threads. It is very difficult
to follow. Bottom post is the norm.

thanks,
-- Shuah 
