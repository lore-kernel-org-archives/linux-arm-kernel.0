From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 May 2012 22:50:00 -0300
Subject: Issues when running DT enabled kernel on iMX28 from linux-next
In-Reply-To: <20120518010138.GA5427@S2101-09.ap.freescale.net>
References: <4FB583CF.2080801@grid-net.com>
 <20120518010138.GA5427@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5D679an+-iaUBXZy+PmHB2tAHhYHUAFWY+4rxSOYiBkyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Thu, May 17, 2012 at 10:01 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Thu, May 17, 2012 at 04:03:43PM -0700, Subodh Nijsure wrote:
>>
>> Should one be able to run top of the linux-next on MX28 EVK hardware
>> with DT support enabled?
>
> Yes, I'm running it well with next-20120516.

Could you please confirm next-20120517 also boots?

I am not getting nothing on console.

This is my U-boot setup:

run netargs; tftpboot 42000000 uImage; tftpboot 42800000
imx28-evk.dtb; bootm 0x4000000 - 0x42000000

Regards,

Fabio Estevam
