From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Mon, 30 Jan 2012 06:58:12 +0000
Subject: [PATCH v2 3/3] arm: da830: move NAND and NOR devices as aemif
 MFD slaves
In-Reply-To: <4F2016F4.2080302@mvista.com>
References: <1327487156-10238-1-git-send-email-prakash.pm@ti.com>
 <1327487156-10238-3-git-send-email-prakash.pm@ti.com>
 <4F2016F4.2080302@mvista.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3175BD35@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Jan 25, 2012 at 20:21:32, Sergei Shtylyov wrote:
> Hello.
> 
> On 01/25/2012 01:25 PM, Manjunathappa, Prakash wrote:
> 
> > NAND and NOR device are made as aemif devices slave, hence device
> > registration achieved via aemif MFD driver.
> 
> > Signed-off-by: Manjunathappa, Prakash<prakash.pm@ti.com>
> > ---
> > Since v1:
> > Patch is generated using -M option.
> 
> >   arch/arm/mach-davinci/board-da830-evm.c |   31 +++++++++++++++++++++++--------
> >   1 files changed, 23 insertions(+), 8 deletions(-)
> 
>     Why only this file? Don't other board files have NAND/NOR devices?

Yes I thought of sending board-da850 changes in separate patch. Should I have to send those changes also in this patch?

Thanks,
Prakash
> 
> WBR, Sergei
> 
