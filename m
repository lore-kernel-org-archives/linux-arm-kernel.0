From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 13 Sep 2011 00:27:48 +0530
Subject: [PATCH v3 1/6] DMA: PL330: move filter function into driver
In-Reply-To: <1315852165-32402-2-git-send-email-thomas.abraham@linaro.org>
References: <1315852165-32402-1-git-send-email-thomas.abraham@linaro.org>
	<1315852165-32402-2-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CABb+yY0Z5qH5TDAr+5mthzH8pdTu3Gfrzk9CLRWiJQ4n15eKEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 11:59 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> The dma channel selection filter function is moved from plat-samsung
> into the pl330 driver. In additon to that, a check is added in the
> filter function to ensure that the channel on which the filter has
> been invoked is pl330 channel instance (and avoid any incorrect
> access of chan->private in a system with multiple types of DMA
> drivers).
>
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
