From: tony@atomide.com (Tony Lindgren)
Date: Thu, 28 Mar 2013 08:58:04 -0700
Subject: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
In-Reply-To: <24838523.73311.1364448607026.JavaMail.apache@mail82.abv.bg>
References: <24838523.73311.1364448607026.JavaMail.apache@mail82.abv.bg>
Message-ID: <20130328155803.GT10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* ?????? ???????? <freemangordon@abv.bg> [130327 22:34]:
>  Tony,
> 
> Who do you expect to make that code merge? Do you expect us to mechanically merge RX51 PPA API patch with the existing generic OMAP PPA API code putting #ifdefs all over the place? Not that it is impossible, but the only real piece of HW I have here is n900, so I just can't be sure the code will still work on the other platforms besides RX51, once the code modified. Please, advice on how to proceed.

Probably ifdefs won't work nice for other omapss. It seems that
your original patch is pretty close based on all that's been
discussed. Can you please repost with a proper patch description
also summarizing why we cannot have generci SMC API as discussed?

Thanks,

Tony
