From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Wed, 25 Jan 2012 17:51:32 +0300
Subject: [PATCH v2 3/3] arm: da830: move NAND and NOR devices as aemif
 MFD slaves
In-Reply-To: <1327487156-10238-3-git-send-email-prakash.pm@ti.com>
References: <1327487156-10238-1-git-send-email-prakash.pm@ti.com>
 <1327487156-10238-3-git-send-email-prakash.pm@ti.com>
Message-ID: <4F2016F4.2080302@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/25/2012 01:25 PM, Manjunathappa, Prakash wrote:

> NAND and NOR device are made as aemif devices slave, hence device
> registration achieved via aemif MFD driver.

> Signed-off-by: Manjunathappa, Prakash<prakash.pm@ti.com>
> ---
> Since v1:
> Patch is generated using -M option.

>   arch/arm/mach-davinci/board-da830-evm.c |   31 +++++++++++++++++++++++--------
>   1 files changed, 23 insertions(+), 8 deletions(-)

    Why only this file? Don't other board files have NAND/NOR devices?

WBR, Sergei
