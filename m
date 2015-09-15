From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Sep 2015 10:12:36 +0200
Subject: [PATCH] ARM: tegra: Enable CPUFreq support for Tegra124
 Chromebooks
In-Reply-To: <CAAObsKA0N50gfPA9sMZfnM8N+N9Oo-YHMCDdF7JdWjpxXtFJbA@mail.gmail.com>
References: <1433331821-9648-1-git-send-email-jonathanh@nvidia.com>
 <556EE8B0.2060205@nvidia.com> <55A3B848.2080205@nvidia.com>
 <CAAObsKA0N50gfPA9sMZfnM8N+N9Oo-YHMCDdF7JdWjpxXtFJbA@mail.gmail.com>
Message-ID: <20150915081234.GA25970@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2015 at 03:40:45PM +0200, Tomeu Vizoso wrote:
> On 13 July 2015 at 15:08, Jon Hunter <jonathanh@nvidia.com> wrote:
> > On 03/06/15 12:44, Jon Hunter wrote:
> >> Adding LAKML. Jon
> >>
> >> On 03/06/15 12:43, Jon Hunter wrote:
> >>> Add the device-tree DFLL clock node and CPU regulator phandle for
> >>> tegra124 chromebooks to enable CPUFreq support on these boards.
> 
> Ping.
> 
> Thanks,

Sorry that this has gone unnoticed for so long. I've applied it now to
the for-4.4/dt branch.

Tomeu, do you want me to add your Tested-by, Reviewed-by or Acked-by
before I push this out?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150915/40189def/attachment.sig>
