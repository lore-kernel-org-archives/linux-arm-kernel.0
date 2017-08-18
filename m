From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Aug 2017 22:45:08 +0200
Subject: [GIT PULL 3/6] Broadcom devicetree-arm64 changes for 4.14
In-Reply-To: <20170817183748.1450-4-f.fainelli@gmail.com>
References: <20170817183748.1450-1-f.fainelli@gmail.com>
 <20170817183748.1450-4-f.fainelli@gmail.com>
Message-ID: <CAK8P3a3Rodk8SQcNT-JBtZReJ4V0r+zb2DPCjy=1r6CeGbQPAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 8:37 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> This pull request contains Broadcom ARM64-based SoCs Device Tree changes for
> 4.14, please pull the following:
>
> - Scott moves all the Northstar 2 DTS files into a sub-directory to be consistent
>   with what was done for stingray and to future proof the addition of new board
>   DTS files
>
> - Velibor adds the ARM CCN-502 interconnect DT node to the Stingray SoC
>   DTS include file
>
> - Srinath adds the MDIO multiplexer and SATA nodes to the Stingray DTS
>   include files
>
> - Anup adds the SP804 timers, FlexRM (mailbox) and RAID engine DT nodes
>   to the Stingray DTS include files
>
> - Abishek adds the BGMAC (Ethernet controller) node to the Stingray DTS
>   files

Pulled into next/dt64, thanks!

      Arnd
