From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 18 May 2012 09:58:07 +0800
Subject: Issues when running DT enabled kernel on iMX28 from linux-next
In-Reply-To: <CAOMZO5D679an+-iaUBXZy+PmHB2tAHhYHUAFWY+4rxSOYiBkyw@mail.gmail.com>
References: <4FB583CF.2080801@grid-net.com>
 <20120518010138.GA5427@S2101-09.ap.freescale.net>
 <CAOMZO5D679an+-iaUBXZy+PmHB2tAHhYHUAFWY+4rxSOYiBkyw@mail.gmail.com>
Message-ID: <CAAQ0ZWRB1=pFqtL_2y-D-f4_VM21o9U1G9F3PMwNgM4ewKmkWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 May 2012 09:50, Fabio Estevam <festevam@gmail.com> wrote:
> Could you please confirm next-20120517 also boots?
>
> I am not getting nothing on console.
>
> This is my U-boot setup:
>
> run netargs; tftpboot 42000000 uImage; tftpboot 42800000
> imx28-evk.dtb; bootm 0x4000000 - 0x42000000
>
The addresses in bootm mismatch the ones in tftpboot?

Regards,
Shawn
