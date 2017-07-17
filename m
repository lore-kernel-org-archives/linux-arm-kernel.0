From: jdelvare@suse.de (Jean Delvare)
Date: Mon, 17 Jul 2017 10:05:50 +0200
Subject: [PATCH v4 1/3] cpufreq: mediatek: Add support of cpufreq to
 MT2701/MT7623 SoC
In-Reply-To: <1499918078.2392.14.camel@mtksdaap41>
References: <cover.1499692967.git.sean.wang@mediatek.com>
 <feabcfd53899954198c6620e9d9b68f4a3c55201.1499692967.git.sean.wang@mediatek.com>
 <1499741386.12408.11.camel@mtksdaap41>
 <12f23fb1-a145-bdf0-54c8-c2818ba75d9d@gmail.com>
 <20170713031614.GH1679@vireshk-i7>
 <1499918078.2392.14.camel@mtksdaap41>
Message-ID: <20170717100550.29c6b3d3@endymion>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 13 Jul 2017 11:54:38 +0800, Eddie Huang wrote:
> On Thu, 2017-07-13 at 08:46 +0530, Viresh Kumar wrote:
> > I am fine with both. Maybe don't resend for just that, mediatek
> > doesn't sound any bad.  
> 
> I am also fine with both. I think most people won't confuse about mtk
> and mediatek. I don't like send patches to just only change filenames
> and kconfig, especially kconfig modification will affect project
> defconfigs. My point is we shouldn't spend much time on this topic, and
> revisit filename when that driver need support new SoC, like this case.

I believe that being consistent is important, and I believe that
3-letter abbreviations are confusing. So in my ideal fantasy world, all
these drivers would be named *mediatek* and their config options would
be CONFIG_*MEDIATEK*. That being said, it's only my general opinion on
the topic. I'm not going to send any patch to rename any of these
drivers, as I have many tasks of higher priority on my own plate. And I
agree that renaming existing drivers does have a cost as well. So
whatever is decided is fine with me, really.

-- 
Jean Delvare
SUSE L3 Support
