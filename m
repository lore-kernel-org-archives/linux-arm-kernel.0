From: andy@warmcat.com (=?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?=)
Date: Thu, 28 Jun 2012 22:49:46 +0800
Subject: [RFC PATCH 0/2] OMAP2+: PANDA: Provide unique-ish MAC addresses
 for Ethernet and WLAN interfaces
In-Reply-To: <1340894707.16702.76.camel@gandalf.stny.rr.com>
References: <20110324211451.14936.39750.stgit@otae.warmcat.com>
 <201206281418.16854.arnd@arndb.de>
 <1340894707.16702.76.camel@gandalf.stny.rr.com>
Message-ID: <4FEC6F0A.5060600@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/12 22:45, the mail apparently from Steven Rostedt included:
> On Thu, 2012-06-28 at 14:18 +0000, Arnd Bergmann wrote:
>
>> It's been a while since we discussed these patches, but Steven Rostedt
>> just tripped over the same problem and the patches work for
>> him, so he says "Tested-by: Steven Rostedt <rostedt@goodmis.org>".
>>
>> Can we get the patches into linux-3.6 please?
>
> Yes please.
>
> Right now I have my ktest.pl setup adding these patches before running
> tests. I really dislike having to modify a kernel that I'm testing,
> because I'm not really testing that said kernel, but a modified version
> of it.

Guys I am glad you're finding the patches useful; I've been using them 
in the Linaro TI Lnding Team trees ever since.

I adapted them a bit to live mainly in devices.c, tomorrow I'll send 
this version cleaned up and we can deal with any further changes needed 
hopefully quickly.

-Andy
