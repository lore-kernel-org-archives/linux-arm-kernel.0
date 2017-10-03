From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 3 Oct 2017 15:21:25 +0100
Subject: [PATCH] ARM: vexpress/spc: Delete an error message for a failed
 memory allocation in two functions
In-Reply-To: <557666e2-45b6-8f47-2fc9-756bd7f23541@users.sourceforge.net>
References: <557666e2-45b6-8f47-2fc9-756bd7f23541@users.sourceforge.net>
Message-ID: <eb4e21f3-f16c-e640-80b2-0d12b01ea4e2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am not sure if such trivial patches get merged by someone via
kernel-janitors list with just maintainers ack or not. Please let
me know if you want me to pickup this, for now I am just Ack-ing.

On 03/10/17 09:40, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Oct 2017 10:30:07 +0200
> 
> Omit extra messages for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
