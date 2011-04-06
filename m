From: mmarek@suse.cz (Michal Marek)
Date: Wed, 06 Apr 2011 10:23:07 +0200
Subject: [PATCH 33/34] usb/lh7a40x_udc: Drop __DATE__ usage
In-Reply-To: <20110405162512.GB11737@n2100.arm.linux.org.uk>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
	<1302015561-21047-34-git-send-email-mmarek@suse.cz>
	<20110405162512.GB11737@n2100.arm.linux.org.uk>
Message-ID: <4D9C22EB.7070106@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5.4.2011 18:25, Russell King - ARM Linux wrote:
> On Tue, Apr 05, 2011 at 04:59:20PM +0200, Michal Marek wrote:
>> The kernel already prints its build timestamp during boot, no need to
>> repeat it in random drivers and produce different object files each
>> time.
> 
> This file no longer exists.

I only tested the series on top of 2.6.38. I dropped this patch now,
sorry for the noise.

Michal
