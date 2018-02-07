From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Wed, 7 Feb 2018 17:31:34 +0100
Subject: [PATCH v5 03/16] media: rkisp1: Add user space ABI definitions
In-Reply-To: <1514533978-20408-4-git-send-email-zhengsq@rock-chips.com>
References: <1514533978-20408-1-git-send-email-zhengsq@rock-chips.com>
 <1514533978-20408-4-git-send-email-zhengsq@rock-chips.com>
Message-ID: <d98ac356-a482-f26f-fd6b-6142281d99c3@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29/2017 08:52 AM, Shunqian Zheng wrote:
> From: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Add the header for userspace
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> ---
>  include/uapi/linux/rkisp1-config.h | 757 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 757 insertions(+)
>  create mode 100644 include/uapi/linux/rkisp1-config.h
> 
> diff --git a/include/uapi/linux/rkisp1-config.h b/include/uapi/linux/rkisp1-config.h
> new file mode 100644
> index 0000000..0f9f4226
> --- /dev/null
> +++ b/include/uapi/linux/rkisp1-config.h
> @@ -0,0 +1,757 @@

<snip>

> +/**
> + * enum cifisp_exp_ctrl_auotostop - stop modes

auotostop -> autostop

> + * @CIFISP_EXP_CTRL_AUTOSTOP_0: continous measurement

continous -> continuous

> + * @CIFISP_EXP_CTRL_AUTOSTOP_1: stop measuring after a complete frame
> + */
> +enum cifisp_exp_ctrl_auotostop {

auotostop -> autostop

> +	CIFISP_EXP_CTRL_AUTOSTOP_0 = 0,
> +	CIFISP_EXP_CTRL_AUTOSTOP_1 = 1,
> +};

Just noticed this :-)

Regards,

	Hans
