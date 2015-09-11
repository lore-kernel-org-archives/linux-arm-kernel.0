From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 11 Sep 2015 17:22:32 +0100
Subject: [PATCH] arm/xen: Enable user access to the kernel before issuing
 a privcmd call
In-Reply-To: <1441981760.3549.57.camel@citrix.com>
References: <1441980963-9002-1-git-send-email-julien.grall@citrix.com>
 <1441981760.3549.57.camel@citrix.com>
Message-ID: <55F2FFC8.1030707@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ian,

On 11/09/15 15:29, Ian Campbell wrote:
>> After the commit a5e090acbf545c0a3b04080f8a488b17ec41fe02 "ARM:
>> software-based priviledged-no-access support", the kernel can't access
> 
> "privileged"

That was a typo in the commit title of the patch. So I won't fix this one.

All the others will be fixed on the next version.

Regards,

-- 
Julien Grall
