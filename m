From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 30 Jul 2015 23:37:27 +0900
Subject: [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
In-Reply-To: <2681271.3UazeZ9PAQ@amdc1976>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
 <3141301.RS9TLygaba@amdc1976> <20150727113641.GB10181@linux>
 <2681271.3UazeZ9PAQ@amdc1976>
Message-ID: <55BA36A7.3050107@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/15 20:47, Bartlomiej Zolnierkiewicz wrote:
> On Monday, July 27, 2015 05:06:41 PM Viresh Kumar wrote:
>> On 27-07-15, 13:14, Bartlomiej Zolnierkiewicz wrote:
>>> Sorry but you don't seem to understand the issue.
>>
>> :)
>>
>> No, I did. I understand that if someone uses opp bindings today with
>> some entries as turbo OPPs, cpufreq will use them as normal
>> frequencies. And that may harm the board.
>>
>> BUT, opp-v2 code isn't ready to be used yet. And platforms should see
>> what all is implemented before trying to use them.
> 
> OK.
> 
>> All I was saying is, this isn't a FIX as we haven't introduced the
>> feature yet. Otherwise I had no issues with the patch.
> 
> I will update the description for the next patchset revision.
> 
Hi Bart,

When will you re-post v3? Because I have a plan to send a pull-request
to arm-soc until this weekend...

- Kukjin
