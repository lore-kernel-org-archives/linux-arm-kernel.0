From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 21 Jan 2013 19:04:45 +0100
Subject: [PATCH 2/6] clocksource: time-armada-370-xp: add local timer
 support
In-Reply-To: <20130121175927.GV23505@n2100.arm.linux.org.uk>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <1358790842-2986-3-git-send-email-gregory.clement@free-electrons.com>
 <20130121175927.GV23505@n2100.arm.linux.org.uk>
Message-ID: <50FD833D.5040604@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2013 06:59 PM, Russell King - ARM Linux wrote:
> On Mon, Jan 21, 2013 at 06:53:58PM +0100, Gregory CLEMENT wrote:
>> +struct clock_event_device __percpu **percpu_armada_370_xp_evt;
>> +
> 
> Have you run this through checkpatch?  Should the above be static?
> 

Yes (and it didn't complain) and yes it should be static, I will fix
this in the V2.

Thanks

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
