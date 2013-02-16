From: gang.chen@asianux.com (Chen Gang)
Date: Sat, 16 Feb 2013 16:38:12 +0800
Subject: [PATCH] ARM:kernel: a bug by a redundancy charactor ';'
In-Reply-To: <511F3D8C.6090603@gmail.com>
References: <511F2C0D.4030206@asianux.com> <511F3D8C.6090603@gmail.com>
Message-ID: <511F4574.7000707@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?02?16? 16:04, Dirk Behme ??:
> 
> Wondering against which branch this patch is, I found that this issue
> isn't in recent mainline from today, but in -next. Introduced by the patch
> 
> ARM: perf: simplify __hw_perf_event_init err handling
> http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=9dcbf466559f6f2f55d60eb5a1bbebc8e694b52a
> 

  for me, either regressing the original patch or committing current
patch are all OK.

> 
> While the subject/commit message could be improved (at least mentioning
> 'perf' somehow and charactor -> character), the change itself looks good.

  if still suggest to commit current patch:
    does the subject like this ?
     [PATCH] ARM:kernel: a bug for perf by a redundancy character ';'


  :-)

  thanks.

-- 
Chen Gang

Asianux Corporation
