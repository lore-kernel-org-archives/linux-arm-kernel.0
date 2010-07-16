From: lee.jones@canonical.com (Lee Jones)
Date: Fri, 16 Jul 2010 12:12:07 +0100
Subject: [PATCH] Stop ARM boards crashing when CUPS is loaded -	2.6.35-rc5
In-Reply-To: <4C402746.6080309@canonical.com>
References: <4C3C72C6.4000005@canonical.com>	<20100715130214.4c9303b2.akpm@linux-foundation.org>	<20100715200618.GA6773@n2100.arm.linux.org.uk>	<4C40218A.4090806@canonical.com>	<20100716092018.GB16995@n2100.arm.linux.org.uk>
	<4C402746.6080309@canonical.com>
Message-ID: <4C403E87.4040503@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/07/10 10:32, Lee Jones wrote:
>> The best solution is probably for the parport code to go through a
>> modernisation cycle like the serial code did, essentially using
>> platform devices to pass the base addresses.  This would make the
>> driver more portable, and eliminates this problem entirely (because
>> platforms which don't have parports won't register the platform device(s)
>> necessary for parport to even probe illegal addresses.)

I have lobbied for one of our partners to conduct this work, but I don't
think this would be something that is in their interest to fix. 
Nevertheless, I am currently waiting on a reply from them.

FAO GregKH,

Do you think this would be something that may interest you and your Linux 
drivers project? Or perhaps a student who wants to get their feet wet and
play with some platform driver code.
