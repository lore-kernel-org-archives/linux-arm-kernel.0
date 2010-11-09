From: alchark@gmail.com (Alexey Charkov)
Date: Tue, 9 Nov 2010 12:49:25 +0300
Subject: [PATCH 6/6 v4] ARM: Add support for the display controllers in
	VT8500 and WM8505
In-Reply-To: <20101109093925.GA21814@linux-sh.org>
References: <1289147348-31969-1-git-send-email-alchark@gmail.com>
	<1289147348-31969-6-git-send-email-alchark@gmail.com>
	<20101108041721.GA11605@linux-sh.org>
	<20101108141407.GA25739@alchark-u3s.lan>
	<20101108204315.GA12050@linux-sh.org>
	<AANLkTikXffMT9ZiUpm2QAoW+KPJN3MBf55Dgruj1EJN0@mail.gmail.com>
	<20101108213008.GB17708@linux-sh.org>
	<20101108234239.GA20819@alchark-u3s.lan>
	<20101108235407.GB18385@linux-sh.org>
	<AANLkTim047K-RjLLcz3124Wm+-he8s5AirAsD6R_kitN@mail.gmail.com>
	<20101109093925.GA21814@linux-sh.org>
Message-ID: <AANLkTi=es0vAWeNjWMDEi8Es97uxsgb9A2aNovp7z8Uh@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/9 Paul Mundt <lethal@linux-sh.org>:
> On Tue, Nov 09, 2010 at 03:03:01AM +0300, Alexey Charkov wrote:
>> Is there anybody I should address specifically to get this merged?
>>
> I've set up an fbdev tree now, so I'll just take this through there. It
> looks like the ordering shouldn't be important, so this can be applied
> independent of the rest, and it simply won't show up until the other bits
> have settled in .38.
>

Yes, the different parts of the patch series are completely
independent, apart from the corresponding platform definitions and
memblock reservations that take place in PATCH 1/6 (which contains
basic board code).

Thanks,
Alexey
