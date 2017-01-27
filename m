From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Jan 2017 17:27:54 +0100
Subject: [PATCH] ARM: ep93xx: Disable TS-72xx watchdog before uncompressing
In-Reply-To: <633e3405-c66d-0503-2626-36ebb0cfb756@gmail.com>
References: <20161211191615.13696-1-f.fainelli@gmail.com>
 <6d58631d-37a2-8362-e9aa-0c360fac4509@gmail.com>
 <SN1PR0101MB1565EBACEA749241E3FC3169D0910@SN1PR0101MB1565.prod.exchangelabs.com>
 <633e3405-c66d-0503-2626-36ebb0cfb756@gmail.com>
Message-ID: <CAK8P3a0dMXHb04w+-Q4fE1ek=uGX=HjODsVU1=gfNoRpGourDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 2:05 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 12/19/2016 08:08 AM, Hartley Sweeten wrote:
>> On Sunday, December 18, 2016 7:08 PM, Florian Fainelli wrote:
>>> Le 12/11/16 ? 11:16, Florian Fainelli a ?crit :

>> Ryan has an old tree on github but it has not been updated since Oct 14, 2013.  I'm
>> not sure if he is doing any active development at this time.
>>
>> This patch will have to go through RMK's patch system or some other tree.
>
> Olof, Arnd, Kevin, should I just resent this patch to arm at kernel.org for
> you to pick it?

Yes, that would be good. I've added it to my todo folder now, but
having the patch
itself there is easier for us.

     Arnd
