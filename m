From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 22 Oct 2014 12:27:38 -0300
Subject: [PATCH 4/4] ARM: dts: Enable the reference clock for timer and
 watchdog on Armada 375 SoC
In-Reply-To: <20141022155510.5fee5f8e@free-electrons.com>
References: <1413984884-20273-1-git-send-email-ezequiel.garcia@free-electrons.com>	<1413984884-20273-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141022155510.5fee5f8e@free-electrons.com>
Message-ID: <5447CCEA.7010109@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2014 10:55 AM, Thomas Petazzoni wrote:
> Dear Ezequiel Garcia,
> 
> On Wed, 22 Oct 2014 10:34:44 -0300, Ezequiel Garcia wrote:
> 
>> -				clocks = <&coreclk 0>;
>> +				clocks = <&refclk>;
>> +				clock-names = "fixed";
> 
> Why not do like we do on Armada XP, and actually represent the
> hardware, by showing that it takes two clocks as input:
> 

Yes, I guess that would work.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
