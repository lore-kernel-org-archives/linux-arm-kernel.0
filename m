From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 5 Sep 2016 16:42:48 +0100
Subject: [PATCH v8 15/18] ARM: STi: DT: STiH407: Add uniperif reader dt
 nodes
In-Reply-To: <ae089830-b7c8-ee83-f697-6ff93f2646ed@st.com>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
 <1472223413-7254-16-git-send-email-peter.griffin@linaro.org>
 <20160830100148.GO1661@dell>
 <20160830142112.GA22514@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160831112819.GJ27357@dell>
 <ae089830-b7c8-ee83-f697-6ff93f2646ed@st.com>
Message-ID: <20160905154248.GU4921@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 05 Sep 2016, Arnaud Pouliquen wrote:
> >>>> +			dai-name = "Uni Reader #0 (PCM IN)";
> >>>
> >>> Oooo, not seen something like this before.
> >>>
> >>> If it does not already have one, it would require a DT Ack.
> >>
> >> No idea, the driver got merged 1 year ago.
> This field could be suppressed and handled in source code, using
> st,uniperiph-id to retreive it.

That would be better.

> >> Arnaud did you get a DT ack when you merged this driver & binding? i if i remember well, i had  sent to Alsa mailing list only, I missed
> this obvious...

I'm surprised Mark didn't notice this.

He's usually pretty good at picking stuff like that up.

> >>>> +			st,version = <3>;
> >>>
> >>> This will likely need a DT Ack too.  We usually encode this sort of
> >>> information in the compatible string.
> yes, better to use compatibility
> >>
> >> See 05c1b4480e86a871b18030d6f3d532dc0ecdf38c
> > 
> > Well Rob's the boss.  We certainly never used to take 'device ID' or
> > 'version' attributes.  I guess something must have changed.
> 
> I will try to provide patches for code and bindings rework this week.

Wonderful.. Thanks Arnaud.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
