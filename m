From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 3 Apr 2013 23:48:10 +0300
Subject: [PATCH] Revert "OMAP/serial: Fix incorrect Rx FIFO threshold
 setting, LSR validation on Tx, and Tx FIFO IRQ generation"
In-Reply-To: <CAOmKuSqd=gNYFutpgDref58pbAbDwDin4mvL_OEooD1XuwKtgQ@mail.gmail.com>
References: <alpine.DEB.2.00.1304010519260.28273@utopia.booyaka.com>
 <CAOmKuSpttQJmrL=Htiz-Zc4voAF7CnG_GQYAO2onKpauwYjtvw@mail.gmail.com>
 <alpine.DEB.2.00.1304010844100.28273@utopia.booyaka.com>
 <CAOmKuSrABrPcZ=Yg1+LAHWbh9CdTYR0eUmJ2dd3z91oz0uu21g@mail.gmail.com>
 <alpine.DEB.2.00.1304011008230.28273@utopia.booyaka.com>
 <CAOmKuSrbDc025Tj9xsqDebJ_KZdp_VnWAOs_OO5UAegV43JcDQ@mail.gmail.com>
 <CAOmKuSpbaKutLxbNihBRDz+B0Wt0XiPss-PcEHc-efCTvciNFg@mail.gmail.com>
 <alpine.DEB.2.00.1304011654520.9148@utopia.booyaka.com>
 <CAOmKuSo4onVtk2Ke-i+0_1Ych33KuUYspRy+cySRHf4yWB5XDw@mail.gmail.com>
 <alpine.DEB.2.00.1304021821190.27146@utopia.booyaka.com>
 <CAOmKuSqd=gNYFutpgDref58pbAbDwDin4mvL_OEooD1XuwKtgQ@mail.gmail.com>
Message-ID: <CANOLnOPc-=RP8K8A8sda6riBNTHG0vBAeGtryXALgewm53_B3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 3, 2013 at 12:19 AM, Alexey Pelykh <alexey.pelykh@gmail.com> wrote:
>
> But, since we've found the issue, I suggest that we should look at it
> closer, especially since at this moment only you can reproduce it. As

FWIW I was also affected by it, maybe because my console is on UART3
and that is on different power (or was is clock?) domain than UART1.


--
Gra?vydas
