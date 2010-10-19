From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Oct 2010 14:54:00 -0200
Subject: [PATCH 1/1] Mx35pdk: enable debug board support
In-Reply-To: <AANLkTimqGRiP1QUtNdJuyQMN_bf+4R7dEn-LNd7bhAu4@mail.gmail.com>
References: <1287129633-9244-1-git-send-email-jgq516@gmail.com>
	<AANLkTikY=wBiJZ0NFKJKX-TTKRAj_LWmaxD-BpuPNYzL@mail.gmail.com>
	<AANLkTi=jyQDNmGK1-VB_xOP8H4+jXNwS6oHgft90gGLW@mail.gmail.com>
	<AANLkTim65XWxn_Mc59PXbiOOqUVMDNqeweU38y_3R7_X@mail.gmail.com>
	<AANLkTi=upCD4iKhkvkzk7Kcb++OYR3pZTQw4i9fTEkFg@mail.gmail.com>
	<AANLkTimqGRiP1QUtNdJuyQMN_bf+4R7dEn-LNd7bhAu4@mail.gmail.com>
Message-ID: <AANLkTinD_LWiqh9Pc-jOsKArfBBLAYeExgfdNMb5CaAT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 1:59 PM, xiao jiang <jgq516@gmail.com> wrote:
>
>
...
>>
> I don't think so, since **_PIN_** is expected for IOMUX_TO_IRQ, not
> **_PAD_**, and I think kernel can't pass compile with
> "IOMUX_TO_IRQ(MX35_PAD_GPIO1_1__GPIO1_1)"

Have you tried the same method as in MX51_3ds?

#define EXPIO_PARENT_INT    (MXC_INTERNAL_IRQS + GPIO_PORTx + y)

Regards,

Fabio Estevam
