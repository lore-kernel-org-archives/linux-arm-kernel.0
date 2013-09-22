From: cinifr@gmail.com (cinifr)
Date: Sun, 22 Sep 2013 21:50:50 +0800
Subject: [PATCH V3: Add Smp support for Allwinner A20. 1/3] Add smp
 support for Allwinner A20(sunxi 7i).
In-Reply-To: <20130922130056.GQ12758@n2100.arm.linux.org.uk>
References: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
 <1379852488-32147-2-git-send-email-cinifr@gmail.com>
 <20130922130056.GQ12758@n2100.arm.linux.org.uk>
Message-ID: <CAK3cCBzc8Ms03xLGsRaOtJikDw9Z3Tq3tWgh8VmkwVJGZU_BWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yes, I get it, it is cause by using ./scripts/Lindent. I have to
remail patch aggin. :)

On 22 September 2013 21:00, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Sep 22, 2013 at 08:21:26PM +0800, Fan Rong wrote:
>> +.section ".text.head", "ax" ENTRY(sun7i_secondary_startup)
>> +msr cpsr_fsxc,
>> +#0xd3
>> +b secondary_startup ENDPROC(sun7i_secondary_startup)
>
> This looks like it's been messed up somehow.
>
