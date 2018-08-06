From: mpatocka@redhat.com (Mikulas Patocka)
Date: Mon, 6 Aug 2018 10:13:19 -0400 (EDT)
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <CAPv3WKeVkWChEE7WjKuu__bg+zvh9dTNy=U_2jiSyWxFWiatbA@mail.gmail.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com>
 <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
 <alpine.LRH.2.02.1808031424140.14030@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3s-+Qf=WBZz1KpisDMG3520jCUh8PLAO3PHa4jdt8kCTw@mail.gmail.com>
 <CAKv+Gu9_h-WFi1j4+DWUN_dMj75SKKHxWoDH8WQ9P7S7MNpZQg@mail.gmail.com>
 <alpine.LRH.2.02.1808060553130.30832@file01.intranet.prod.int.rdu2.redhat.com>
 <99fff4fe-afa9-f12f-a518-472a9dd1c530@arm.com>
 <CAPv3WKdxwoW5MAOvy6uEBEuMpsigMo98hyO+TpKMsFrKR9oBzg@mail.gmail.com>
 <CAKv+Gu8XN-vP64G_NLHFcRUJ2fptSrmxfd6CHWDgHkJj073Hbg@mail.gmail.com>
 <CAPv3WKeVkWChEE7WjKuu__bg+zvh9dTNy=U_2jiSyWxFWiatbA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.1808061008520.9697@file01.intranet.prod.int.rdu2.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Mon, 6 Aug 2018, Marcin Wojtas wrote:

> > Hi Marcin,
> >
> > Could you please try running his reproducer?
> 
> This is exactly what I plan to do, as soon as I can plug my GFX card
> back to the board (tomorrow). Just to remain aligned - is it ok, if I
> boot my debian with GT630 plugged, compile the program with -O2 and
> simlply run it on /dev/fb0?
> 
> Best regards,
> Marcin

Yes - when you run it, don't switch consoles (it will obviously trigger 
false warning), don't move the mouse to the upper left corner, and if you 
want to run it in the long term, turn off console blanking.

Mikulas
