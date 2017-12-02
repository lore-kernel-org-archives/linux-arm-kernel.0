From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Sat, 2 Dec 2017 12:19:54 +0100
Subject: linux-next on Nokia N900: hang on boot
In-Reply-To: <20171202101456.GA1810@amd>
References: <20171202101456.GA1810@amd>
Message-ID: <20171202111954.4gg43xkb2wf5ebmn@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 December 2017 11:14:56 Pavel Machek wrote:
> Hi!
> 
> next from 2017-12-01 was tested.
> 
> MMC is detected, but then I see wtl4030_bci: .. battery temperature
> out of range, and machine halts. This is just before userspace would
> be started.
> 
> 4.15-rc1 seems to work ok on the box.
> 
> Any ideas?

twl4030_bci is not available on Nokia N900, so we should not try to read
its registers.

-- 
Pali Roh?r
pali.rohar at gmail.com
