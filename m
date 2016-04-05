From: david@lechnology.com (David Lechner)
Date: Tue, 5 Apr 2016 11:51:10 -0500
Subject: [PATCH v3 0/5] davinci_mmc fixes
In-Reply-To: <CAPDyKFp3UELfw2gNTh0GeX31bjwb8tbDiua6ZigLwhaUkcv3zA@mail.gmail.com>
References: <1458186341-6970-1-git-send-email-david@lechnology.com>
 <CAPDyKFp3UELfw2gNTh0GeX31bjwb8tbDiua6ZigLwhaUkcv3zA@mail.gmail.com>
Message-ID: <5703ECFE.6060706@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/2016 06:12 AM, Ulf Hansson wrote:
>
> Patch 3 triggers a compiler warning, please fix it.
>
> ../drivers/mmc/host/davinci_mmc.c: In function ?davinci_mmcsd_probe?:
> ../drivers/mmc/host/davinci_mmc.c:1208:6: warning: ?ret? may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>
> I have applied patch 1->2 for next, so no need to resend these.
>
> Kind regards
> Uffe
>

I am not getting a compiler warning with this commit. Can you please 
provide a git link so that I can be sure I am building using the same 
branch that you are using?
