From: tom.leiming@gmail.com (Ming Lei)
Date: Sat, 17 Dec 2011 00:33:23 +0800
Subject: [QUESTION] How to set static/dynamic dependency between clock
 domains
In-Reply-To: <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
 <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
Message-ID: <CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 17, 2011 at 12:09 AM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:
> No. The table reflects the actual possible combination on hardware. You can't
> add anything there arbitrary if that combination is not supported.
>
> But that makes me wonder how the patch worked. I will look at this in detail
> next week.

Thanks, I use the below hwmod data patch[1] and omap device patch[2]
to bring up fdif module, and Benoit has ACKed on patch [1].


[1], http://marc.info/?l=linux-kernel&m=132387140703874&w=2
[2], http://marc.info/?l=linux-kernel&m=132387155403929&w=2

thanks,
-- 
Ming Lei
