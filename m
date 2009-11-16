From: abhijeet.tripathy@yahoo.co.in (abhijeet tripathi)
Date: Mon, 16 Nov 2009 20:49:36 +0530 (IST)
Subject: kernel panic - Attempted to kill init
In-Reply-To: <4B012FD3.7000907@who-ing.de>
Message-ID: <174721.58417.qm@web7607.mail.in.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks to all for the suggestions. It helped me to resolve the issue.
I was missing EABI support in my kernel.

--regards,
Abhijeet

--- On Mon, 16/11/09, Sebastian Heutling <heutling@who-ing.de> wrote:

> From: Sebastian Heutling <heutling@who-ing.de>
> Subject: Re: kernel panic - Attempted to kill init
> To: "abhijeet tripathi" <abhijeet.tripathy@yahoo.co.in>
> Cc: "linux-arm-kernel at lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gmshastri at gmail.com" <gmshastri@gmail.com>, "abhijeet" <abhijeet.tripathy@gmail.com>, "mayur.nan at gmail.com" <mayur.nan@gmail.com>
> Date: Monday, 16 November, 2009, 4:26 PM
> On 11/16/2009 08:29 AM, abhijeet
> tripathi wrote:
> > Hello,
> >
> > I am trying to do a nfs booting of arm-pb1176 but I am
> getting kernel panic "Kernel panic - not syncing: Attempted
> to kill init!".
> > I checked my filesystem and it has "/sbin/init".
> Please let me know if I am missing anything. Below is the
> console logs:
> 
> Might be that some shared libraries which "/sbin/init"
> depends on are 
> missing.
> 
> Basti
> 
> 


      The INTERNET now has a personality. YOURS! See your Yahoo! Homepage. http://in.yahoo.com/
