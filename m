From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 18 Nov 2011 17:27:12 +0100
Subject: [PATCH] MEM2MEM: Add support for eMMa-PrP mem2mem operations.
In-Reply-To: <4EC682B8.10300@gmail.com>
References: <1321460614-2108-1-git-send-email-javier.martin@vista-silicon.com>
 <4EC682B8.10300@gmail.com>
Message-ID: <CACKLOr0spqXzYZUPcDkDxCqZXkCM+F6crEQ3R0VbS-HGvZADtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,
thank you for your review.

On 18 November 2011 17:07, Sylwester Nawrocki <snjw23@gmail.com> wrote:
> Hi Javier,
>
> Good to see non Samsung device using v4l2 mem-to-mem framework. What is your
> experience, have you encountered any specific problems with it ?

I've found the framework quite convenient and comfortable, it
definitely saves a lot of work and coding once you understand it
properly.
For a simple device as i.MX2 eMMa-PrP a driver can be in a working
state in a couple of days. I've not found any drawbacks.

> And just out of curiosity, are you planning to develop video codec driver
> in v4l2 for i.MX27 as well ?

It depends on the result of a proof of concept we are preparing now.
But yes, it could be possible. AFAIK, Sascha Hauer (added to CC) has a
prototype driver for this one though.

> I have a few comments, please see below...

It seems I'll have to prepare a second version with all the fixes
you've pointed out which seem quite reasonable to me.

Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
