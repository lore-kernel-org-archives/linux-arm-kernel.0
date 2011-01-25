From: wangchendu@gmail.com (sen wang)
Date: Tue, 25 Jan 2011 17:19:16 +0800
Subject: questions about arm trustzone
In-Reply-To: <8yad3nlh18e.fsf@huya.qualcomm.com>
References: <AANLkTi=eCOiP7MrUSG4WRMN0kj_+ZWvZ=z7VYDfkshU_@mail.gmail.com>
	<8yad3nlh18e.fsf@huya.qualcomm.com>
Message-ID: <AANLkTin9fSw5DdqdgCEvtdtc83LFOeA7t0OAUugVmRFD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

thanks,
It seems linux run in the normal world, and the "scm.c" ?is the path
to the monitor mode.
where can I find the example code for monitor and secure world?



2011/1/25 David Brown <davidb@codeaurora.org>:
> On Mon, Jan 24 2011, sen wang wrote:
>
>> we need to build a little os in the secure mode,and run linux in the
>> normal world.but, can I use gcc to compile the special instructions like 'smc'.
>> which gcc version can work? and where can i find the example code
>> switching between the secure and normal worlds?
>
> In the 2.6.38-rc2 kernel, arch/arm/mach-msm/scm.c does this. ?I don't
> think there is any other code in the kernel, yet.
>
> David
>
> --
> Sent by an employee of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
>
