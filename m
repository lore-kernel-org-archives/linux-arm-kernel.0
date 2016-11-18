From: slash.tmp@free.fr (Mason)
Date: Fri, 18 Nov 2016 13:42:44 +0100
Subject: arasan,sdhci.txt "compatibility" DT binding
In-Reply-To: <CAFd313x6MJeO90_+rxditdPn762g7TqZc0_D6ojGTKmtGJKjPA@mail.gmail.com>
References: <56B07BA5.4060407@free.fr> <56B166F1.5080605@rock-chips.com>
 <56B1AA44.1010108@xilinx.com> <56B1BAF8.2050907@free.fr>
 <56B1CF40.1030203@xilinx.com> <20160203152104.GP4215@xsjsorenbubuntu>
 <56B21DDB.6050708@free.fr> <582ED9E0.5090506@free.fr>
 <CAFd313x6MJeO90_+rxditdPn762g7TqZc0_D6ojGTKmtGJKjPA@mail.gmail.com>
Message-ID: <582EF744.8090307@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/11/2016 11:49, Rameshwar Sahu wrote:

> Mason wrote:
>
>> Suman/APM added "arasan,sdhci-4.9a" in 308f3f8d8112
>> @Suman, @Rameshwar: what specific IP block does your SoC embed?
>> What does 4.9a refer to? The documentation revision number?
> 
> We have Arasan SD3.0/ SDIO3.0/ eMMC4.41 AHB Host Controller IP
> embedded in our SoC and 4.9a is documentation revision number which
> was given by Arasan.
> FYI this documentation date was May, 2012.

Hello Ram,

Thanks for the information.

  Xilinx is using "SD2.0/SDIO2.0/MMC3.31 AHB Host Controller"
     APM is using "SD3.0/SDIO3.0/eMMC4.41 AHB Host Controller"
   Sigma is using "SD3.0/SDIO3.0/eMMC4.4 AHB Host Controller"
Rockchip is using ? (Shawn could you specify exactly which IP you use?)

And it looks like Arasan is using different revision numbers for
every documentation they have.

The "SD3.0/SDIO3.0/eMMC4.4 AHB Host Controller" doc I have is
at rev number 6.0, dated 2010-02-19.

Regards.
