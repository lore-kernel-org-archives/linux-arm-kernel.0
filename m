From: matt@genesi-usa.com (Matt Sealey)
Date: Mon, 20 Sep 2010 10:48:17 -0500
Subject: Machine name/id change request
In-Reply-To: <20100920154441.GG30793@n2100.arm.linux.org.uk>
References: <AANLkTikm78_dj03xxaHMi10V+_B9B_8FRg1kRbL2OPBK@mail.gmail.com>
	<20100920154441.GG30793@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikgyzWJN7O44nNoN5d39FDf6eEr+R236ED3zvMG@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 20, 2010 at 10:44 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 20, 2010 at 10:32:51AM -0500, Matt Sealey wrote:
>> Hello,
>>
>> Is it possible for us to change a machine name/id in the database and
>> future kernels?
>>
>> We have two systems originally designed by Pegatron and registered
>> under their codenames, but for now retailing and marketed under the
>> "Efika MX" brand. We would like to change the id data for
>>
>> id 2336, originally MX51_LANGE51 but changed to MX51_EFIKAMX (mx51_efikamx etc.)
>> id 2370, originally MX51_KUNLUN but changed to MX51_EFIKASB (mx51_efikasb etc.)
>
> As they're not in mainline then we can. ?Bear in mind that kernels
> which contain this code using the old identifiers will break when
> someone decides to download a new copy of the file after the change.

I have some sincere doubts this will ever happen. No public kernel has
ever been released with these identifiers and what has been released,
we backdoor changed them to the above anyway.. it's just gotten to the
point that this is going to end up mainlined one way or the other, and
we'd prefer not to confuse people.

> Updated.
>
> Is Sean Hsieh still responsible for these?

No, I guess the new responsible person would be me.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
