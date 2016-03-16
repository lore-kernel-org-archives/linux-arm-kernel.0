From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 16 Mar 2016 16:38:19 +0000
Subject: [STLinux Kernel] [PATCH v5 4/7] remoteproc: Supply controller
 driver for ST's Remote Processors
In-Reply-To: <1452602781-22424-5-git-send-email-lee.jones@linaro.org>
References: <1452602781-22424-1-git-send-email-lee.jones@linaro.org>
 <1452602781-22424-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20160316163819.GA9595@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jan 2016, Lee Jones wrote:

> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/remoteproc/Kconfig         |   9 ++
>  drivers/remoteproc/Makefile        |   1 +
>  drivers/remoteproc/st_remoteproc.c | 297 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 307 insertions(+)
>  create mode 100644 drivers/remoteproc/st_remoteproc.c

Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
