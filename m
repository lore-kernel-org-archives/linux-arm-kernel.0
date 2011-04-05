From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 5 Apr 2011 16:29:09 -0700 (PDT)
Subject: [PATCHv4 2/4] ARM: Allow machines to override __delay()
In-Reply-To: <BANLkTimz0fZnWdGqOF4c+o3Mp4GrmV2T0Q@mail.gmail.com>
References: <1292883633-19553-1-git-send-email-sboyd@codeaurora.org>
	<1292883633-19553-3-git-send-email-sboyd@codeaurora.org>
	<BANLkTimz0fZnWdGqOF4c+o3Mp4GrmV2T0Q@mail.gmail.com>
Message-ID: <986071387c1fa1ede387ff36991a3df8.squirrel@www.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 2010/12/20 Stephen Boyd <sboyd@codeaurora.org>:
>
>> Some machines want to implement their own __delay() routine based
>> on fixed rate timers. Expose functionality to set the __delay()
>> routine at runtime. This should allow two machines with different
>> __delay() routines to happily co-exist within the same kernel
>> with minimal overhead.
>
> Can't you guys just put this into Russell's patch tracker now?
> I think the issues raised have been adressed.
>
> Unless this happens I will attempt to rebase it and put it in
> the patch tracker myself soon-ish.
>

Sorry, I'm about to send it now.
