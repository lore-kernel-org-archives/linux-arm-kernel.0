From: hechtb@gmail.com (Bastian Hecht)
Date: Mon, 4 Mar 2013 16:51:23 +0100
Subject: [PATCH 1/3] clocksource: sh_cmt: Add Device Tree probing
In-Reply-To: <20130304040935.GC26475@linux-sh.org>
References: <1362159932-18533-1-git-send-email-hechtb+renesas@gmail.com>
 <1362159932-18533-2-git-send-email-hechtb+renesas@gmail.com>
 <20130304040935.GC26475@linux-sh.org>
Message-ID: <CABYn4sz=daKATegpFDrCBJTcJ0g1-mNavX2toaFhbDUhcgR++w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

2013/3/4 Paul Mundt <lethal@linux-sh.org>:
> On Fri, Mar 01, 2013 at 11:45:30AM -0600, Bastian Hecht wrote:
>> We add the capabilty to probe SH CMT timer devices using Device Tree
>> setup.
>>
>> We can deduce former platform data by the device IDs and channel
>> IDs of our timer instances, so we choose this more intuitive info as our
>> DT properties.
>>
> I wonder if it makes more sense to attempt to create a more generalized
> binding, as what you have here is pretty much uniform for all of
> CMT/TMU/MTU2. Perhaps having a general sh-timer binding would be cleaner,
> while letting each timer plug the compatible string it cares about.

Yes that sounds good. I'll have a look at the various timers and see
if I can come up with something good.

Thanks,

 Bastian
