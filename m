From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 29 Jul 2015 12:02:50 +0100
Subject: [PATCH 0/8] Use correctly the Xen memory terminologies in Linux
In-Reply-To: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
Message-ID: <55B8B2DA.8090900@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/07/15 16:02, Julien Grall wrote:
> Hi all,
> 
> This patch series aims to use the memory terminologies described in
> include/linux/mm.h [1] for Linux xen code.

I mistakenly wrote the wrong include here. It should be include/xen/mm.h
from the Xen tree:

http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=e758ed14f390342513405dd766e874934573e6cb

Regards,

-- 
Julien Grall
