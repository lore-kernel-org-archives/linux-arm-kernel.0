From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Apr 2017 17:16:53 +0800
Subject: [PATCH 3/3] ARM: sun8i: a83t: Rename pinmux setting names
In-Reply-To: <20170418090447.dcxinewczubf26b7@lukather>
References: <20170418042205.27894-1-wens@csie.org>
 <20170418042205.27894-4-wens@csie.org>
 <20170418090447.dcxinewczubf26b7@lukather>
Message-ID: <CAGb2v65is5iyzXYvJMF7QLWXBdMBpemEm2kmyTnytx7V30M7Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 5:04 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Apr 18, 2017 at 12:22:05PM +0800, Chen-Yu Tsai wrote:
>> The pinmux setting nodes all have an address element in their node
>> names, however the pinctrl node does not have #address-cells.
>>
>> Rename the existing pinmux setting nodes and labels in sun8i-a83t.dtsi,
>> dropping identifiers for functions that only have one possible setting,
>> and using the pingroup name if the function is identically available on
>> different pingroups.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Applied, and I really like the new names.
>
> Would you make the same patch for everyone?

I can. No guarantees on the schedule though.

ChenYu
