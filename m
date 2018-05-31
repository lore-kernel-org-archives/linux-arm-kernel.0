From: gilad@benyossef.com (Gilad Ben-Yossef)
Date: Thu, 31 May 2018 14:55:06 +0300
Subject: [PATCH v2 5/5] arm64: dts: renesas: r8a7795: add ccree binding
In-Reply-To: <20180529161936.prhp4oikzamr6u3n@verge.net.au>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-6-git-send-email-gilad@benyossef.com>
 <20180529161936.prhp4oikzamr6u3n@verge.net.au>
Message-ID: <CAOtvUMeBCH+23c3FDWncMwPPe5N=7yjRKzhyLmFXrYazgGbcJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 7:19 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, May 24, 2018 at 03:19:10PM +0100, Gilad Ben-Yossef wrote:
>> Add bindings for CryptoCell instance in the SoC.
>>
>> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>
> In so far as I can review the details of this (which is not much) this
> looks fine to me. I am, however, a little unclear in when it should be
> accepted.

Since Herbert Xu ACKed the driver changes, I would say the only gating
commit is Geert's CR clock patch.
If that one is in, than I would say this one should go in as well.

Thanks,
Gilad

-- 
Gilad Ben-Yossef
Chief Coffee Drinker

"If you take a class in large-scale robotics, can you end up in a
situation where the homework eats your dog?"
 -- Jean-Baptiste Queru
