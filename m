From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 18 Sep 2009 03:05:56 +0200
Subject: generalise Treo680 code and add support for Palm Centro - round 3
In-Reply-To: <200909172308.40734.sleep_walker@suse.cz>
References: <1252670222-25233-1-git-send-email-sleep_walker@suse.cz>
	<200909172308.40734.sleep_walker@suse.cz>
Message-ID: <200909180305.56427.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 17. z??? 2009 23:08:40 Tom?? 'Sleep_Walker' ?ech napsal(a):
> Hi,
> 
> Dne P? 11. z??? 2009 13:57:00 Tom?? ?ech napsal(a):
> > Hi,
> >
> > this is round 3 of generalisation Treo680 code and consequential add Palm
> > Centro 685 support.
> >
> > Changes since last round:
> > 	- filename is now palmtreo.c to remain Palm devices consistency
> > 	- generic functions are now beginning with treo_ (instead of previous
> > palmgsm_) - pxamci_platform_data now contains also '.gpio_card_ro		= -1,'
> > - added MAINTAINERS entry
> > 	- reduced patchset (patches preceding these are already applied)
> >
> > Thanks for your time.
> >
> > Round 3 - fight!
> 
> Any progress here?

No, stop reopening! (people familiar with glibc will understand here ;-) )

Eric, could you merge this with my ack then ?

Thanks
> 
> Thanks.
> 
> Best regards,
> 
> Tomas Cech
> 
