From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Jun 2013 09:55:14 +0200
Subject: [PATCH v3 1/4] i2c-mv64xxx: Set bus frequency to 100kHz if
 clock-frequency is not provided
In-Reply-To: <20130625214446.GA2951@katana>
References: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
 <1371821529-13791-2-git-send-email-gregory.clement@free-electrons.com>
 <20130625214446.GA2951@katana>
Message-ID: <51CA9E62.6090203@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2013 11:44 PM, Wolfram Sang wrote:
> On Fri, Jun 21, 2013 at 03:32:06PM +0200, Gregory CLEMENT wrote:
>> This commit adds checking whether clock-frequency property acquisition has succeeded. If not, the frequency is set to 100kHz by default.
>> 
>> The Device Tree binding documentation is updated accordingly.
>> 
>> Based on the intials patches from Zbigniew Bodek
>> 
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com> Signed-off-by: Zbigniew Bodek <zbb@semihalf.com>
> 
> Applied to for-next, thanks! Rest of the series is 3.12 material.
> 
Thanks!

For the rest of the series, does it mean that you agree with it, or
that you didn't review it yet?

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
