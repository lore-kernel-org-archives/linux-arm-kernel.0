From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Sun, 15 Jan 2012 01:52:17 +0400
Subject: [PATCH] S3C24XX DMA resume regression fix
In-Reply-To: <1326462444-10567-1-git-send-email-dron0gus@gmail.com>
References: <1326462444-10567-1-git-send-email-dron0gus@gmail.com>
Message-ID: <4F11F911.7030609@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 13-01-2012 17:47, Gusakov Andrey wrote:

> In commit bb072c3cf21d1c9a5a2eeb5a00679ee7bf39675b suspend/resume

    Please also specify that commit's summary in parens.

> hooks were added. s3c2410_dma_suspend suspends channels from 0 to
> dma_channels. s3c2410_dma_resume resumes channels in reverse
> order. So pointer should be decremented insted of being incremented.

> Signed-off-by: Gusakov Andrey<dron0gus@gmail.com>

WBR, Sergei
