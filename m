From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 18 Mar 2014 11:01:23 +0000
Subject: [PATCH 1/5] drivers: input: keyboard: st-keyscan: add keyscan
 driver
In-Reply-To: <53281F1E.7010403@st.com>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-2-git-send-email-gabriel.fernandez@st.com>
 <20140310114819.GO14976@lee--X1> <5322D63D.5030403@st.com>
 <20140314104222.GB3432@lee--X1> <53281F1E.7010403@st.com>
Message-ID: <20140318110123.GP25478@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>Sorry for the delay. It was a hectic week last week.
> >>>
> >>>As promised:
> >>>
> >>>>This patch adds ST Keyscan driver to use the keypad hw a subset
> >>>>of ST boards provide. Specific board setup will be put in the
> >>>>given dt.
> >>>>
> >>>>Signed-off-by: Giuseppe Condorelli<giuseppe.condorelli@st.com>
> >>>>Signed-off-by: Gabriel Fernandez<gabriel.fernandez@st.com>
> >>>Are you sure these are in the correct order?
> >>ok i change the order
> >I'm not saying they are in the wrong order, I'm just asking. Who wrote
> >the patch? Has it changed since?
> Sorry...
> I wrote the patch, then Guiseppe has changed and tested, and I re-modifiedit

Ah, then it starts to get very complicated. :)

If you wrote the patch, you need to be at the top of the list.

<snip>

> >>>+keyscan: keyscan at fe4b0000 {
> >>>+	compatible = "st,keypad";
> >>>Is there any way we can make this more specific to _this_ IP?
> >>for my knowledge this IP is the same for stixxxx platform.
> >So st,stix-keypad, or st,sti4x-keypad?
> >
> >I'm just thinking about future proofing the architecture. What if ST
> >released stj which has a different keypad IP?
> After discussing internally with st  "st,sti-keyscan" is better

Perfect.

<snip>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
