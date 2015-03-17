From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 17 Mar 2015 11:38:04 +0000
Subject: [PATCH 06/35 linux-next] power: constify of_device_id array
In-Reply-To: <1426533469-25458-7-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533469-25458-7-git-send-email-fabf@skynet.be>
Message-ID: <5508121C.4040104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/03/15 19:17, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>

Not sure if you really need acks for simple change like this, anyways
for vexpress parts in patch 06, 26 and 32

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
