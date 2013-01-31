From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 31 Jan 2013 21:54:56 +0530
Subject: BogoMIPS change in 3.6+
In-Reply-To: <510A988F.6030508@gmail.com>
References: <510A988F.6030508@gmail.com>
Message-ID: <510A9AD8.8060003@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 January 2013 09:45 PM, Rob Herring wrote:
> The BogoMIPS value has changed on highbank since the commit below in
> 3.6. It is now half the value it used to be. Does that matter other than
> perception (I've checked that I'm not running at half the freq)?
>
I also stumbled on this while testing Will's series.[1]
There should be no other functional issue apart from getting surprised.

Regards,
Santosh

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-July/109281.html
