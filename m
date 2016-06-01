From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 1 Jun 2016 12:29:24 +0200
Subject: DTS for Zynq Microzed/Picozed
In-Reply-To: <CAK7LNASAe0mFD28sM=8_qDsyeGVH_wZTYyFY1uLEp85LmmSuHQ@mail.gmail.com>
References: <CAK7LNASAe0mFD28sM=8_qDsyeGVH_wZTYyFY1uLEp85LmmSuHQ@mail.gmail.com>
Message-ID: <574EB904.2070900@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,


On 1.6.2016 12:10, Masahiro Yamada wrote:
> Hi Michal,
> 
> 
> zynq-microzed.dts and zynq-picozed.dts are missing
> in Linux tree.
> (I do not see them in linux-xlnx on the GitHub, either)

microzed and picozed board are made by Avnet not by Xilinx and none
pushed support for these boards.

> 
> Interestingly enough, I see both in U-Boot tree.

Yes they are in the u-boot because IRC Nathan wanted to have support there.


> Is there some reason for that?
> Otherwise, do you have a plan to port them to Linux?

I was in touch with Avnet to improve support for their reference boards
but there is no conclusion from that discussion.
I have microzed here (I don't have picozed) but I don't have any
immediate plan to push support for this board to Linux without any
support from them.
And pushing board without regular testing is not the right way to go.

TBH: I am thinking to remove zynq boards which are not regularly tested.
For Linux this is not a problem because diff is just DTS and for U-Boot
with DM I believe we can be there soon.

Thanks,
Michal
