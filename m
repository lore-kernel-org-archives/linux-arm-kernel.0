From: chris@64studio.com (Chris Obbard)
Date: Tue, 13 Mar 2018 13:39:44 +0000
Subject: [linux-sunxi] Re: [PATCH v2 6/6] ASoC: sun4i-i2s: Add support for
 loopback
In-Reply-To: <20180312183521.GP2186@sirena.org.uk>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-7-codekipper@gmail.com>
 <20180312183521.GP2186@sirena.org.uk>
Message-ID: <CAP03XeoaYcMrzv3+K83wGUaDn6ZcCDzePdVNcjAqJ4QrF-WLSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

>
>> +- loopback:  if this property is present then the dai is configured in
>> +             loopback mode where the output fifo is redirected to the input
>> +             fifo.
>
> This really doesn't seem like something that ought to go into the DT
> and hence ABI given that there's obviously no reason to use this in
> production.  Just make it be a #define in the code or something.

It would be nice to have this as an optional devicetree property so
when testing JACK latency etc I don't have to manually re-compile a
kernel...
