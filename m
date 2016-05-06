From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 6 May 2016 11:44:06 -0700
Subject: [PATCH 1/5] remoteproc: core: Task sync during rproc_fw_boot()
In-Reply-To: <1462454983-13168-2-git-send-email-lee.jones@linaro.org>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
 <1462454983-13168-2-git-send-email-lee.jones@linaro.org>
Message-ID: <20160506184406.GD1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 05 May 06:29 PDT 2016, Lee Jones wrote:

> By default, rproc_fw_boot() needs to wait for rproc to be configured,
> but a race may occur when using rpmsg/virtio.  In this case, it can
> be called locally in a safe manor.
> 
> This patch represents two usecases:
> 
>  - External call (via exported rproc_boot()), which waits
>  - Internal call can use 'nowait' version of rproc_boot()
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks good

Applied to rproc-next.

Regards,
Bjorn
