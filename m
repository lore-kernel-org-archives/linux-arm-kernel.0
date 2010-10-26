From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Tue, 26 Oct 2010 14:46:14 +0300
Subject: [PATCH 1/8] staging: tidspbridge - remove req_addr from proc_map
In-Reply-To: <1288054306-4361-2-git-send-email-x0095840@ti.com>
References: <1288054306-4361-1-git-send-email-x0095840@ti.com>
	<1288054306-4361-2-git-send-email-x0095840@ti.com>
Message-ID: <AANLkTimCDM_nruvh_gqxxy0CVnw2sH5UYNT9VgyeBfZN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 3:51 AM, Fernando Guzman Lugo <x0095840@ti.com> wrote:
> The device address is assigned by tidspbridge no need for that parameter anymore.
>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>

This would break the API with user-space, right?

I think this change should be delayed, preferably after we have a
working tidspbridge.

-- 
Felipe Contreras
