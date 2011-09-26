From: khilman@ti.com (Kevin Hilman)
Date: Mon, 26 Sep 2011 15:59:41 -0700
Subject: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
In-Reply-To: <CAC83ZvLcq+N_LL4AD=r4hZxPeQtrAEvR7MzoANtNmQBNR7AqGw@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Tue, 27 Sep 2011 03:40:53 +0530")
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<87mxdwm8pk.fsf@ti.com>
	<CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
	<4E7D99CB.7090004@ti.com>
	<CAC83ZvLfCOjKja1rZ6GB4bmn_KrcjitTJZJsa5jy01QVj2OXXw@mail.gmail.com>
	<87mxdrcfnf.fsf@ti.com>
	<CAC83ZvLcq+N_LL4AD=r4hZxPeQtrAEvR7MzoANtNmQBNR7AqGw@mail.gmail.com>
Message-ID: <87mxdq9ag2.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> [...]
>>> - Added the debounce clock fix in the end.
>>
>> Thanks. ?Glad you found and fixed it.
>>
>> Rather than add this patch as a fix at the end, I prefer if the problem
>> is fixed in the original patches that added/created the problem.
> Sure. I will put the changes in respective patches.

Also, when you rebase, please be sure to add the Acked-by from Tony
to the various patches he ack'd.

Thanks,

Kevin
