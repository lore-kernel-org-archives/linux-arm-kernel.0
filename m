From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Aug 2012 11:10:47 +0900
Subject: [PATCH V2 1/5] include/video: Add samsung FIMD register header
In-Reply-To: <1343737385-23337-2-git-send-email-l.krishna@samsung.com>
References: <1343737385-23337-1-git-send-email-l.krishna@samsung.com>
 <1343737385-23337-2-git-send-email-l.krishna@samsung.com>
Message-ID: <02f101cd6f8a$dd923910$98b6ab30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Leela Krishna Amudala wrote:
> 
> This patch copies the contents from regs-fb-v4.h and regs-fb.h to
> include/video/samsung_fimd.h
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  include/video/samsung_fimd.h |  526
> ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 526 insertions(+), 0 deletions(-)
>  create mode 100644 include/video/samsung_fimd.h
> 
Firstly, please check my comment on your previous patches.

And I don't see following definitions are needed and used now. If some
definitions are not needed, they can be removed.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
