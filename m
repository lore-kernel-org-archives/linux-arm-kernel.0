From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 28 Nov 2016 13:57:11 +0000
Subject: [PATCH 1/2] bus: vexpress-config: fix device reference leak
In-Reply-To: <1479317491-7435-1-git-send-email-sudeep.holla@arm.com>
References: <1479317491-7435-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <96487a8e-237c-9cb0-8cdf-fd6f82ab4a43@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/11/16 17:31, Sudeep Holla wrote:
> From: Johan Hovold <johan@kernel.org>
>
> Make sure to drop the reference to the parent device taken by
> class_find_device() after populating the bus.
>
> Fixes: 3b9334ac835b ("mfd: vexpress: Convert custom func API to regmap")
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/bus/vexpress-config.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> Hi ARM-SoC team,
>
> I am not sure if these couple of patches can be considered as fixes for
> v4.9. I will leave that to you guys.
>
> Can you pick these couple of patches directly either for v4.9 or v4.10 ?
> I am trying to avoid single patch pull requests here. Let me know if
> you prefer PR instead.
>

Gentle ping. It need not go into v4.9. Please pick them for v4.10

-- 
Regards,
Sudeep
