From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Mar 2015 17:10:44 +0530
Subject: [RESEND 0/7] ARM: davinci: McASP related cleanups and fixes
In-Reply-To: <55015C86.2010803@ti.com>
References: <1426147591-31764-1-git-send-email-peter.ujfalusi@ti.com>
 <55015C86.2010803@ti.com>
Message-ID: <5509643C.5090406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 March 2015 02:59 PM, Sekhar Nori wrote:
> Hi Peter,
> 
> On Thursday 12 March 2015 01:36 PM, Peter Ujfalusi wrote:
>> Hi,
>>
>> V1 was sent back in 10th of February [1], so resending it rebased on current
>> linux-next.
>>
>> Clean up series of McASP device creation for da8xx and dm646x DMSoCs.
> 
> All applied. Will send out the pull request soon after a bit of testing.

Tested audio recording and playback on DA850 EVM both with legacy boot
and DT boot. Works great. DaVinci clock code needs a fix though. Will
send out that too.

Thanks,
Sekhar
