From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 11 Apr 2011 23:11:00 +0300
Subject: [PATCH RFC] ARM: PXA27x: CPUFREQ: Don't use fastbus mode
In-Reply-To: <20110411134642.GA1519@ucw.cz>
References: <1301169103-23968-1-git-send-email-anarsoul@gmail.com>
	<4D8EFEC1.7010803@compulab.co.il> <20110411134642.GA1519@ucw.cz>
Message-ID: <201104112311.01002.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 April 2011 16:46:43 Pavel Machek wrote:
> Hi!
> 
> Well, some other pxa27x machcines  (spitz) are crashing randomly for
> _years_ now... so maybe the problem is more widespread?
> 
> How easy is to trigger the problem? Do you have script?
> 
> Is it possible that this bug triggers with governor==performance.

It's hard to trigger it with performance governor (because it's quite stable 
@416mhz even with fastbus), so I suggest trying ondemand or conservative 
governors.
