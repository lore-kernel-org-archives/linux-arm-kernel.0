From: slapdau@yahoo.com.au (Craig McGeachie)
Date: Tue, 24 Jun 2014 18:21:24 +1200
Subject: [RFC PATCH 2/3] Enable BCM2835 mailbox support
In-Reply-To: <1403433943.532.1.camel@goatlord.localdomain>
References: <5232F7C2.3070408@yahoo.com.au>
 <1403433943.532.1.camel@goatlord.localdomain>
Message-ID: <53A918E4.4080707@yahoo.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/06/14 22:45, Lubomir Rintel wrote:
> Hi Craig,
> As the work on common mailbox framework progressed, I've updated the
> driver to work with v7 of it (I've also ported the cpufreq and vchiq
> drivers, which I'd like to post once the mailbox framework and your
> drivers are in):
>
> https://github.com/hackerspace/rpi-linux/commits/lr-vchiq-new-mailbox
>
> I'm not sending inline patches for review, since neither the framework
> nor your your mbox and thermal drivers are in yet, but I'm wondering if
> you could take a look and eventually fold the changes back into your
> drivers? (I've kept them in separate commits in my tree, so that it's
> easy for you to keep track of the changes).

It's been 9 months since I last looked at this.  I've been watching the 
work on the mailbox framework, with considerable interest, over the last 
week, but have not actively done anything with it.

I have a few other projects at the moment, and given that I only do this 
in my spare time in the evenings, it will take several days to get back 
into it.  But I will make an effort to import, build, and try them out. 
In the meantime I've had a brief look at the changes that you made and 
can see nothing wrong with any of them.  The "useless gotoes" were 
embarrassing.

Although I can pull your changes back into my tree, I don't feel that 
this will be helpful in getting them accepted into the mainline. But I'm 
happy enough to format a patch and submit it somewhere, at some point.

Cheers,
Craig.
