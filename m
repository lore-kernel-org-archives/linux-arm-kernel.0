From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Jan 2013 17:59:05 +0530
Subject: [PATCH v5 6/9] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <CAK=WgbbShpqxS7zrDs97HkjpyWq0xzW3b9KHLBBs_V3YzdJKiA@mail.gmail.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-7-git-send-email-rtivy@ti.com>
 <CAK=WgbZVayi-USPCwB3KSbzRQ_oxatznt4d26A8_GpWmay2daA@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FE538@DFLE08.ent.ti.com>
 <50F51E43.2090605@ti.com>
 <CAK=WgbbShpqxS7zrDs97HkjpyWq0xzW3b9KHLBBs_V3YzdJKiA@mail.gmail.com>
Message-ID: <50F54B91.4030406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/15/2013 3:33 PM, Ohad Ben-Cohen wrote:
> On Tue, Jan 15, 2013 at 11:15 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> Right, and platform data is not the way to achieve this.
> 
> How do you suggest to handle platforms with multiple different remote
> processors (driven by the same driver) ?
> 
> Requiring the user to indicate the fw name for each processor is
> somewhat error prone/cumbersome.

May be rproc_alloc() could auto-assign the firmware name to something
like 'rproc%d-fw' if firmware name passed to it is NULL?

Thanks,
Sekhar
