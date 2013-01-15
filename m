From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 15 Jan 2013 12:03:26 +0200
Subject: [PATCH v5 6/9] ARM: davinci: Remoteproc driver support for
 OMAP-L138 DSP
In-Reply-To: <50F51E43.2090605@ti.com>
References: <1357863807-380-1-git-send-email-rtivy@ti.com>
 <1357863807-380-7-git-send-email-rtivy@ti.com>
 <CAK=WgbZVayi-USPCwB3KSbzRQ_oxatznt4d26A8_GpWmay2daA@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C14311FE538@DFLE08.ent.ti.com>
 <50F51E43.2090605@ti.com>
Message-ID: <CAK=WgbbShpqxS7zrDs97HkjpyWq0xzW3b9KHLBBs_V3YzdJKiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 11:15 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> Right, and platform data is not the way to achieve this.

How do you suggest to handle platforms with multiple different remote
processors (driven by the same driver) ?

Requiring the user to indicate the fw name for each processor is
somewhat error prone/cumbersome.

Thanks,
Ohad.
