From: tomeu.vizoso@gmail.com (Tomeu Vizoso)
Date: Tue, 15 Sep 2015 11:00:17 +0200
Subject: [PATCH] ARM: tegra: Enable CPUFreq support for Tegra124
 Chromebooks
In-Reply-To: <20150915081234.GA25970@ulmo.nvidia.com>
References: <1433331821-9648-1-git-send-email-jonathanh@nvidia.com>
 <556EE8B0.2060205@nvidia.com> <55A3B848.2080205@nvidia.com>
 <CAAObsKA0N50gfPA9sMZfnM8N+N9Oo-YHMCDdF7JdWjpxXtFJbA@mail.gmail.com>
 <20150915081234.GA25970@ulmo.nvidia.com>
Message-ID: <CAAObsKAuJz6KoexA2VHPxxVCZ9PbUAFWUx6tSOmdPYq50u_=-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 September 2015 at 10:12, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Thu, Sep 03, 2015 at 03:40:45PM +0200, Tomeu Vizoso wrote:
>> On 13 July 2015 at 15:08, Jon Hunter <jonathanh@nvidia.com> wrote:
>> > On 03/06/15 12:44, Jon Hunter wrote:
>> >> Adding LAKML. Jon
>> >>
>> >> On 03/06/15 12:43, Jon Hunter wrote:
>> >>> Add the device-tree DFLL clock node and CPU regulator phandle for
>> >>> tegra124 chromebooks to enable CPUFreq support on these boards.
>>
>> Ping.
>>
>> Thanks,
>
> Sorry that this has gone unnoticed for so long. I've applied it now to
> the for-4.4/dt branch.
>
> Tomeu, do you want me to add your Tested-by, Reviewed-by or Acked-by
> before I push this out?

I haven't done proper tests, but I have tested for several weeks a
branch containing these changes on a nyan-big and have found no
issues.

You can add my Reviewed-by though. Sorry for not having made this clear.

Thanks,

Tomeu

> Thierry
