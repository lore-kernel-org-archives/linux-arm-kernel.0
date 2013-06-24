From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 24 Jun 2013 12:04:41 -0600
Subject: [PATCH] pinctrl: establish pull-up/pull-down terminology
In-Reply-To: <3185376.o7RqphCDfQ@avalon>
References: <1371379548-6482-1-git-send-email-linus.walleij@stericsson.com>
 <51C2F7BE.2060805@imgtec.com> <51C4A447.3090807@wwwdotorg.org>
 <3185376.o7RqphCDfQ@avalon>
Message-ID: <51C88A39.3040201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 05:30 PM, Laurent Pinchart wrote:
> Hi Stephen,
> 
> On Friday 21 June 2013 13:06:47 Stephen Warren wrote:
...
>> IIRC the idea of the PULL_PIN_DEFAULT was to avoid having to specify
>> UP/DOWN for each pin/group, but could just say "default", which would
>> then reduce the number of pinctrl mapping table entries or pinctrl DT
>> property entries.
> 
> I may be mistaken, but I've understood the PULL_PIN_DEFAULT option as a way to 
> select the default bias configuration when the default value is hardware-
> controlled, not as a pure software option.

That's my understanding too.
