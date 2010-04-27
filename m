From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 27 Apr 2010 13:05:38 +0300
Subject: [PATCH 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100423042626.GA2997@localhost.localdomain>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
	<20100422120308.GD26418@gw.healthdatacare.com>
	<20100423030556.GA8012@localhost.localdomain>
	<20100423041106.GG3028@esdhcp04058.research.nokia.com>
	<20100423042626.GA2997@localhost.localdomain>
Message-ID: <20100427100538.GB12682@esdhcp04058.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 23, 2010 at 06:26:26AM +0200, ext Janboe Ye wrote:
> These are some other hard code address in some boards.
> 
> For example, beagle board boot_params is 0x80000100.
> 
> I guest nokia's Nseris does not use atags for transfering params.
> 
> When I test my relocated kernel, it blocks at machinee initialization.
> 
> Maybe there is other address mapping issue. I will look it tomorrow.

Hi again,

I got it working on beagle with following patches. Hope it helps you.

Regards,
MW
