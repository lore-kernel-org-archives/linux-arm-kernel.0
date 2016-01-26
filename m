From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Jan 2016 14:51:25 -0800
Subject: N900 sleep mode (in 4.5-rc0, if that matters)
In-Reply-To: <20160126172527.GY3500@atomide.com>
References: <20160123121022.GB12497@amd> <20160125163332.GT19432@atomide.com>
 <20160126140010.GA29723@amd> <20160126172527.GY3500@atomide.com>
Message-ID: <20160126225125.GD19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [160126 09:26]:
> 
> Looks like we have some regression with v4.5-rc1 where n900 is not
> hitting deeper idle states though. I'll run git bisect between
> v4.4..v4.5-rc1.

Sent more info about that in thread "PM regression with commit
5de85b9d57ab PM runtime re-init in v4.5-rc1" FYI.

Tony
