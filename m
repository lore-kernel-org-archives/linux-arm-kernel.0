From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 16 Mar 2016 16:44:22 +0000
Subject: [STLinux Kernel] [PATCH v5 3/7] remoteproc: debugfs: Add ability
 to boot remote processor using debugfs
In-Reply-To: <1452602781-22424-4-git-send-email-lee.jones@linaro.org>
References: <1452602781-22424-1-git-send-email-lee.jones@linaro.org>
 <1452602781-22424-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20160316164422.GD9595@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jan 2016, Lee Jones wrote:

> This functionality is especially useful during the testing phase.  When
> used in conjunction with Mailbox's Test Framework we can trivially conduct
> end-to-end testing i.e. boot co-processor, send and receive messages to
> the co-processor, then shut it down again (repeat as required).
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/remoteproc/remoteproc_debugfs.c | 34 +++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Acked-by: Peter Griffin <peter.griffin@linaro.org>
