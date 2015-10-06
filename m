From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Oct 2015 16:37:49 +0100
Subject: [PATCH V5 0/2] copy to/in/from user optimization
In-Reply-To: <1443034539-1848-1-git-send-email-fkan@apm.com>
References: <1443034539-1848-1-git-send-email-fkan@apm.com>
Message-ID: <20151006153748.GD3069@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 11:55:37AM -0700, Feng Kan wrote:
> This coverts all copy in/from/to user file to use the copy template file.
> The copy template file is based on the memcpy.S. The first patch converts
> the memcpy to use the copy template as well. Overnight trinity test and
> 10G iperf was used to test correctness and performance. Noticeable
> iperf improvement (~30%) on the receive side.
> 
> V5 Changes:
>    1. Switch patch ordering.
>    2. Simplify assembly code and use fixed large tags in marco
>    3. Fixed indentation issue.
> 
> Feng Kan (2):
>   arm64: Change memcpy in kernel to use the copy template file
>   arm64: copy_to-from-in_user optimization using copy template

Queued for 4.4 (subject to passing my LTP testing). Thanks.

-- 
Catalin
