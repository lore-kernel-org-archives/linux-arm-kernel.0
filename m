From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 6 May 2016 11:48:42 -0700
Subject: [PATCH 2/5] remoteproc: core: Add rproc OF look-up functions
In-Reply-To: <1462454983-13168-3-git-send-email-lee.jones@linaro.org>
References: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
 <1462454983-13168-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20160506184842.GE1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 05 May 06:29 PDT 2016, Lee Jones wrote:

> - of_rproc_byindex(): look-up and obtain a reference to a rproc
>   		      using the DT phandle "rprocs" and a index.
> 
> - of_rproc_byname():  lookup and obtain a reference to a rproc
>   		      using the DT phandle "rprocs" and "rproc-names".
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---

I like the idea of having these helpers, but we already have
rproc_get_by_phandle() so these helpers should be built upon that rather
than adding the additional list.

Regards,
Bjorn
