From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 03 Nov 2014 15:12:24 -0800
Subject: [GIT PULL] ARM: brcmstb: SMP, Kconfig, earlyprintk and GISB fixes
In-Reply-To: <CAOesGMgy7pgX7z5reMpPXfs8CXfB3sQuJzXMZsGHhWFrbyAyuA@mail.gmail.com>
References: <1413840408-14860-1-git-send-email-f.fainelli@gmail.com>	<20141103222800.GJ23619@ld-irv-0074>
 <CAOesGMgy7pgX7z5reMpPXfs8CXfB3sQuJzXMZsGHhWFrbyAyuA@mail.gmail.com>
Message-ID: <54580BD8.3050401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2014 03:10 PM, Olof Johansson wrote:
> On Mon, Nov 3, 2014 at 2:28 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
>> On Mon, Oct 20, 2014 at 02:26:48PM -0700, Florian Fainelli wrote:
>>> These changes were posted late during the v3.18 release cycle, and were
>>> eventually added to your 'late' branch, but here is an updated version
>>>
>>> Thanks!
>>>
>>> The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:
>>>
>>>   Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   http://github.com/brcm/linux.git tags/brcmstb-smp-uart-for-3.19
>>>
>>> for you to fetch changes up to 203bb85ed605e43eadca62afb3a8cd128a8ec10a:
>>>
>>>   bus: brcmstb_gisb: save and restore GISB timeout (2014-10-20 12:44:42 -0700)
>>
>> Forgive me if I'm being dense, but I don't see these changes in
>> linux-next, and I only see a portion of them in arm-soc/brcmstb/smp-uart
>> (plus, they're old, so there are merge conflicts). Did these get
>> overlooked?
> 
> Not overlooked, we're just running way behind on merges.

I believe the changes Brian refers to is your merge of our 3.18 pull
request in your 'late' branch, these changes are now superseded by this
exact pull request we are discussing right now, which is intended for
3.19 (hope this clears things out).

> 
> I'll do a sweep today/tonight and start doing merges. I normally do it
> chronologically though and there are even older ones to take care of.
> I'll get to this quickly I hope.

Cool, thanks!
--
Florian
