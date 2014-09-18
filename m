From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Fri, 19 Sep 2014 00:31:54 +0200
Subject: [PATCH 0/6] Add initial support for Broadcom Cygnus SoC
In-Reply-To: <1410897497-27527-1-git-send-email-jonathar@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
 <1410897497-27527-1-git-send-email-jonathar@broadcom.com>
Message-ID: <541B5D5A.10800@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2014 09:58 PM, Jonathan Richardson wrote:
> Hi,
> 
> This patchset contains initial support for Broadcom's Cygnus SoC based on our
> iProc architecture. Initial support is minimal and includes just the mach
> platform code, clock driver, and a basic device tree configuration. Peripheral
> drivers will be submitted soon, as will device tree configurations for other
> Cygnus board variants.

This SoC looks similar to the BCM5301X (Northstar) SoCs even some cores
are at the same memory addresses. Does this SoC use an AXI bus with
Broadcom Plugins at address 0x18000000 ?

The BCM5301X (Northstar) SoCs also has an iProc Clock Control Unit and I
will try to use your driver for that SoC.

Is Broadcom Cygnus similar to BCM563XX or is it actually the same SoC?

Do you have some description of the hardware features of this SoC? Does
it have PCIe, or Ethernet?

Hauke
