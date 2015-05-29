From: jkosina@suse.cz (Jiri Kosina)
Date: Fri, 29 May 2015 13:52:31 +0200 (CEST)
Subject: [RFC PATCH 0/5] livepatch: add support on arm64
In-Reply-To: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
References: <1432792265-24076-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <alpine.LNX.2.00.1505291350510.26271@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 May 2015, Li Bin wrote:

> This patchset propose a method for gcc -mfentry feature(profile
> before prologue) implementation for arm64, and propose the livepatch
> implementation for arm64 based on this feature.
> The gcc implementation about this feature will be post to the gcc 
> community soon.
> 
> With this -mfentry feature, the entry of each function like:
> 
> foo:
>     mov x9, x30 
>     bl __fentry__
>     mov x30, x9
>     [prologue]
>     ... 

Thanks a lot for working on arm64 support. I am putting this patchset on 
hold before gcc support is merged. Once that happens, and once the arm64 
parts are Acked by the arch maintainers, we could proceed with this patch.

-- 
Jiri Kosina
SUSE Labs
