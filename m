From: baohua@kernel.org (Barry Song)
Date: Tue, 6 May 2014 09:10:32 +0800
Subject: [PATCH v2 2/2] spi: sirf: decrease the interrupt count and
 latency of PIO mode
In-Reply-To: <20140505192344.GL22111@sirena.org.uk>
References: <1399185156-521-1-git-send-email-swingboard@gmail.com>
 <20140505192344.GL22111@sirena.org.uk>
Message-ID: <CAGsJ_4zN6mpa1_auXAiV5RsEPkgB7924MDZvfvh5AqGgZAizgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-05-06 3:23 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Sun, May 04, 2014 at 02:32:36PM +0800, Qipan Li wrote:
>> From: Qipan Li <Qipan.Li@csr.com>
>>
>> current PIO tranfer method be described as follows:
>
> I'm missing patch 1 here.

this is a follow of "[PATCH 2/2] spi: sirf: decrease the interrupt
count and latency of PIO mode", as you have applied 1/2 - [PATCH 1/2]
spi: sirf: refactor spi transfer functions, so there is no patch 1/2
here.
qipan made a typo , this should be directly a patch but not a 2/2. so
pls take it as a separate patch.

-barry
