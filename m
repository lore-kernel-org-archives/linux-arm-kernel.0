From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 27 Jul 2015 12:00:55 +0100
Subject: inquiries on juno
In-Reply-To: <CAN2waFtHqy+CV3nu3ZdGsxjTwD35xuhXiAn0tPrd4ZPYR7Ujww@mail.gmail.com>
References: <CAN2waFugZ869RZe_3GbW+8qCZQL-h9fRt5g38JJUPkr8f8VR5A@mail.gmail.com>	<55B20037.2090705@arm.com>	<CAN2waFsDuw4s9AqU=6D5vfgHSK5iDknkxD5UR06yXGe+GGNSrg@mail.gmail.com>	<55B236E2.8050600@arm.com>
 <CAN2waFtHqy+CV3nu3ZdGsxjTwD35xuhXiAn0tPrd4ZPYR7Ujww@mail.gmail.com>
Message-ID: <55B60F67.9000408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/07/15 11:16, Zhaoyang Huang wrote:
> Dear Sudeep,
> I applied the patch you mentioned on the git tree of v4.1 and get the
> error for[1]. Then I cherry-picked the commit[3] which I get from github
> where the missing function defined, while there is another error[2]. I
> am not sure if I am on the right way? Thank you!
>

I haven't tried that patch on v4.1, so I am not aware of all the
dependencies you may be missing. I have tried only on v4.2-rc* and it
works fine to me.

Other option would be to have "earlycon" in cmdline but remove baud in
stdout-path in Juno DT and see if it provides any log as where it's
getting hung during the boot.

But I repeat that v4.1 with defconfig and DT compiled from source just
works fine unless you are missing something in the firmware including 
DT. Hope that helps.

Regards,
Sudeep.
