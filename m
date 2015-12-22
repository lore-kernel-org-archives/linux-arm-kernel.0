From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 22 Dec 2015 11:21:57 +0800
Subject: [PATCH 5/5] ARM: dts: sun5i: Add backlight node to
 sun5i-q8-common.dtsi
In-Reply-To: <5df61312-cf32-43d4-8aba-485acf66787d@googlegroups.com>
References: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
 <1442752251-20744-6-git-send-email-hdegoede@redhat.com>
 <5df61312-cf32-43d4-8aba-485acf66787d@googlegroups.com>
Message-ID: <CAGb2v65SHwxOftyBFYD2pR3Q2QAAcFGqcNk=StdFaGdz5CZGww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2015 at 6:54 PM,  <8001010@gmail.com> wrote:
>> +             default-brightness-level = <8>;
>
>
> Why?
> Is not better 100% ?

It's just an arbitrary value. Plus having the backlight at 100% on battery
powered devices might eat up the battery quicker.

ChenYu
