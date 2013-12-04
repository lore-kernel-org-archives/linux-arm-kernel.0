From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 4 Dec 2013 11:21:33 +0530
Subject: [PATCH 2/2] ARM: tegra: convert device tree file of Dalmore to
 use pinctrl defines
In-Reply-To: <529E3A6E.1050003@wwwdotorg.org>
References: <1385992502-12771-1-git-send-email-ldewangan@nvidia.com>
 <1385992502-12771-2-git-send-email-ldewangan@nvidia.com>
 <529E3A6E.1050003@wwwdotorg.org>
Message-ID: <529EC2E5.5050909@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 December 2013 01:39 AM, Stephen Warren wrote:
> On 12/02/2013 06:55 AM, Laxman Dewangan wrote:
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Patch description?
>
> BTW, did you compile all the Tegra DT files before and after this
> change, and make sure that there's zero difference between them (i.e.
> they're identical byte-for-byte when compiled)? I don't feel like
> manually double-checking this entire patch...

I just made changes for the Dalmore only. Not touched Tegra30 and 
Tegra20_ platform dts.

For Dalmore, I compare the binary before and after this change as well 
dts generated back from dtb using dtc.
It is same.
