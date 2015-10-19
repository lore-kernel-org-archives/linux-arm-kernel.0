From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 19 Oct 2015 18:40:52 +0100
Subject: [PATCH 14/17] media: st-rc: remove misuse of IRQF_NO_SUSPEND flag
In-Reply-To: <1442850433-5903-15-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-15-git-send-email-sudeep.holla@arm.com>
Message-ID: <56252B24.4000207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21/09/15 16:47, Sudeep Holla wrote:
> The device is set as wakeup capable using proper wakeup API but the
> driver misuses IRQF_NO_SUSPEND to set the interrupt as wakeup source
> which is incorrect.
>
> This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
> enable_irq_wake instead.
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

Can you pick couple of these media patches ?

-- 
Regards,
Sudeep
