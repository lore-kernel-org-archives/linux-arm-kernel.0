From: shawn.gsc@gmail.com (Shawn Guo)
Date: Fri, 22 Oct 2010 02:14:01 +0800
Subject: [PATCH 1/2] mmc: quirk fix for timeout problem
In-Reply-To: <alpine.LFD.2.00.1010211308340.2764@xanadu.home>
References: <1287564807-1645-1-git-send-email-shawn.gsc@gmail.com>
	<1287566576-1224-1-git-send-email-shawn.gsc@gmail.com>
	<20101020112741.GB10261@pengutronix.de>
	<AANLkTinairUcKpTH2ePjbp3j7qdsmrPCeeWR_E+RSsPU@mail.gmail.com>
	<alpine.LFD.2.00.1010211308340.2764@xanadu.home>
Message-ID: <AANLkTikokkVaAjA+b6f56Syv0h8odiN4koJTOaFW_Ebx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It also works fine on mx35_3ds without that timeout quirk.

My mx25_3ds gets something wrong.  Will try to fix it and test this tomorrow.


On Fri, Oct 22, 2010 at 1:10 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Fri, 22 Oct 2010, Shawn Guo wrote:
>
>> Hi Wolfram,
>>
>> On Wed, Oct 20, 2010 at 7:27 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> > On Wed, Oct 20, 2010 at 05:22:56PM +0800, Shawn Guo wrote:
>> >> This patch is to fix timeout problem which was seen on babbage.
>> >> Thanks Richard Zhu <r65037@freescale.com> for catching this.
>> >>
>> >> Signed-off-by: Shawn Guo <shawn.gsc@gmail.com>
>> >
>> > NACK. It is still untested if we need that quirk on MX25/35.
>> > Eric wanted to send an updated patch next week.
>> >
>>
>> I just tested the code change on mx35_3ds and mx25_3ds, and no problem
>> was seen. ?I will send the patch for mmc support on mx35_3ds and
>> mx25_3ds soon.
>
> The question is... is this quirk actually needed on those? ?Did you test
> _without_ it?
>
>
> Nicolas
>



-- 
Regards,
Shawn
