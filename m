From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 18 Dec 2012 18:35:37 +0530
Subject: [PATCH 1/4] ARM: tegra30: Add support for Uart clock source
 divider as 15.1
In-Reply-To: <50D0163F.3030806@nvidia.com>
References: <1355746101-15291-1-git-send-email-ldewangan@nvidia.com>
 <1355746101-15291-2-git-send-email-ldewangan@nvidia.com>
 <50CF91F7.5010402@wwwdotorg.org> <50D009E0.3050409@nvidia.com>
 <50D00C1D.9090100@nvidia.com> <50D0163F.3030806@nvidia.com>
Message-ID: <50D06A21.2000102@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 December 2012 12:37 PM, Prashant Gaikwad wrote:
> On Tuesday 18 December 2012 11:54 AM, Laxman Dewangan wrote:
>> On Tuesday 18 December 2012 11:44 AM, Prashant Gaikwad wrote:
>>>
>>> My clock driver rework includes this fix. Divider supports both DIVU71
>>> and DIVU151.
>>> UART divider is set to DIVU151.
>> Prashant,
>> I like to go this patch as first patch towards bug fixes rather than
>> after moving the clock. The reason is that we will pull this change in
>> our downstream and will be available in our K3.7 code.
> Laxman,
>
> We are not going to use ccf in our downstream kernel port to K3.7. How
> does that help pushing in upstream?

Ok, as per our internal discussion, I am going to drop first three 
patches. I will relookinto these patches once your series get applied 
and will work if there is any missing items.


Stephen,
I will respin the 4th patch based on how the discussion on serial driver 
goes. I will send the new patch for 4th change.
