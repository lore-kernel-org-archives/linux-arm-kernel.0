From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 18 May 2012 00:05:14 -0300
Subject: Issues when running DT enabled kernel on iMX28 from linux-next
In-Reply-To: <20120518023318.GB5427@S2101-09.ap.freescale.net>
References: <4FB583CF.2080801@grid-net.com>
 <20120518010138.GA5427@S2101-09.ap.freescale.net>
 <CAOMZO5D679an+-iaUBXZy+PmHB2tAHhYHUAFWY+4rxSOYiBkyw@mail.gmail.com>
 <CAAQ0ZWRB1=pFqtL_2y-D-f4_VM21o9U1G9F3PMwNgM4ewKmkWQ@mail.gmail.com>
 <CAOMZO5Aj0cfpJwMEQwOvM9cM52=W5Rtr5kKxqgw1JG_5AQ5t+g@mail.gmail.com>
 <20120518023318.GB5427@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5B8tyAtmcuPUbRCdEa6V3EJ0Cfe39cRf3MRiN641osJow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 11:33 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The next-20120517 seems working for me too.
>
> You can turn on low-level debug option to see where it goes wrong
> at your end.

Ok, so I changed the bootloader to U-boot 2012.04.01 +
CONFIG_OF_LIBFDT, and now it boots fine.

Thanks,

Fabio Estevam
