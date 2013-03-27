From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Mar 2013 13:56:07 -0700
Subject: [PATCH] arm: omap: RX-51: ARM errata 430973 workaround
In-Reply-To: <201303241526.59275@pali>
References: <517283541.62064.1362124023621.JavaMail.apache@mail81.abv.bg>
 <20130306175120.GP11806@atomide.com> <201303062013.16302@pali>
 <201303241526.59275@pali>
Message-ID: <20130327205606.GN10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [130324 07:31]:
> it is possible to upstream errata 430973 workaround for RX-51?

I think we should make the SMC handling a generic function for ARM.

AFAIK just the SMC call numbering is different for various
implementations. So the handler and passing of the parameters
seems like it should be generic.

Regards,

Tony
