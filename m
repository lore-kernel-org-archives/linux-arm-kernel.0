From: stigge@antcom.de (Roland Stigge)
Date: Fri, 07 Dec 2012 13:16:33 +0100
Subject: [PATCH 0/6 v10] gpio: Add block GPIO
In-Reply-To: <50C1DBD4.1040007@antcom.de>
References: <1354830456-17590-1-git-send-email-stigge@antcom.de>
 <20121207103643.34ca6dc5@pyramind.ukuu.org.uk> <50C1DBD4.1040007@antcom.de>
Message-ID: <50C1DE21.8050709@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2012 01:06 PM, Roland Stigge wrote:
> On 12/07/2012 11:36 AM, Alan Cox wrote:
>>> * Device interface for userland access (alternative to sysfs)
>>
>> Currently we can set different permissions on different GPIO lines. Your
>> driver change drives a truck through this facility.

What I maybe misread in your concern: The dev interface is actually an
"alternative to sysfs for block GPIO", not considered as a replacement
for the current sysfs interface for _single_ GPIOs.

The fate of the latter one can be discussed separately.

Also, the sysfs interface for block GPIO can be left out of my patch
series, if necessary.

Roland
