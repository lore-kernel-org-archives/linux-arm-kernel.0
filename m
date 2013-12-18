From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Wed, 18 Dec 2013 14:10:13 +0100
Subject: [PATCH v5 2/2] ARM: mach-moxart: add MOXA ART SoC device tree
 files
In-Reply-To: <CAEgOgz7kqU-Z6cQk8kiMBiNs=9coOVq-6it1eKEiN62wKXcsZg@mail.gmail.com>
References: <1387294714-12872-1-git-send-email-jonas.jensen@gmail.com>
 <1387294714-12872-3-git-send-email-jonas.jensen@gmail.com>
 <CAEgOgz7kqU-Z6cQk8kiMBiNs=9coOVq-6it1eKEiN62wKXcsZg@mail.gmail.com>
Message-ID: <CACmBeS2amFHRQM9HB5pvT5eZYYidWHDNBsWEvSpMKAy7yCqmPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the replies, changes should be in v6.

On 18 December 2013 00:29, Peter Crosthwaite
<peter.crosthwaite@xilinx.com> wrote:
>> +       clocks {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               ref12: ref12M {
>> +                       compatible = "fixed-clock";
>> +                       #clock-cells = <0>;
>> +                       clock-frequency = <12000000>;
>
> Crystal board level?

I couldn't move this due to fixed-clock load order.

See my comments in v6 cover letter:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/220302.html


Thanks,
Jonas
