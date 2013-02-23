From: rob@landley.net (Rob Landley)
Date: Sat, 23 Feb 2013 14:05:42 -0600
Subject: [PATCH v2 0/5] Generic PHY Framework
In-Reply-To: <20130219150500.GG4390@arwen.pp.htv.fi> (from balbi@ti.com on
 Tue Feb 19 09:05:00 2013)
Message-ID: <1361649942.11282.13@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2013 09:05:00 AM, Felipe Balbi wrote:
> Greg, can you pitch your suggestion here ? It would be great to hear
> your rationale behind dropping class infrastructure, couldn't find
> anything through Google and since feature-removal-schedule.txt has  
> been
> removed (without adding it to feature-removal-schedule.txt, I must add
> :-) I don't know what's the idea behind removing classes.

I actually went through and poked a couple of people about old entries  
in feature-removal-shedule.txt last year, but I haven't been very  
active since the kernel.org breakin because my account got disabled,  
and I needed to meet kernel developers in person to get keys signed to  
get it switched back on (or set up a separate git tree with signed  
commits -next could pull from).

I don't get out much; as a consultant I have to take time off from work  
and pay for my own travel and lodging. So I've been to exactly two  
conferences in the past 3 years: last year's Texas Linux Fest (my house  
got broken into and a netbook with the key on it stolen the following  
wednesday), and CELF (which I'm on the plane back from now, Greg KH  
signed my key! Woo!).

If I can use that to get my account back, set up a tree feeding into  
linux-next, and maybe even recover the ability to update  
http://kernel.org/doc, I'd happily field some sort of  
feature-removal-schedule list and make sure it stays current. (Linus  
didn't ask me about removing the old one, I found out about it from the  
git log. But I can't blame him, I haven't exactly been tearing through  
the bureaucracy to get my access back. "Volunteer work" and "painful"  
tend not to combine well on my todo list in terms of scheduling  
priority...)

Rob
