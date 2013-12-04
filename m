From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 4 Dec 2013 11:17:41 +0530
Subject: [PATCH] ARM: tegra: convert device tree files to use key defines
In-Reply-To: <529E393C.4010604@wwwdotorg.org>
References: <1385989797-10879-1-git-send-email-ldewangan@nvidia.com>
 <529E393C.4010604@wwwdotorg.org>
Message-ID: <529EC1FD.2080806@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 December 2013 01:34 AM, Stephen Warren wrote:
> On 12/02/2013 06:09 AM, Laxman Dewangan wrote:
>> Use key code macros for all key code refernced for keys.
>>
>> For tegra20-seaboard.dts and tegra20-harmony.dts:
>>    The key comment for key (16th row and 1st column) is KEY_KPSLASH but
>>    code is 0x004e which is the key code for KEY_KPPLUS. As there other
>>    key exist with KY_KPPLUS, I am assuming key code is wrong and comment
>>    is fine. With this assumption, I am keeping the key code as KEY_KPSLASH.
> This looks reasonable, and I'll apply it soon. What is the patch based
> on? Note that I recently sent a patch to fix the sort order of DT nodes
> in all Tegra DT files, which I'll apply early since it's a cleanup, and
> IIRC some of the KBC nodes may have been moved by that patch, so this
> may conflict. I'll see if I can rebase while applying it.
I worked on linux-next of 20131202.

If there is any issue,  I can generate new patch based on the branch 
which you suggest.
