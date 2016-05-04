From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 5 May 2016 00:49:49 +0300
Subject: [PATCH 24/25] arm64:ilp32: add vdso-ilp32 and use for signal
 return
In-Reply-To: <57289C75.50904@huawei.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1554541.oDP7Ro5zB2@wuerfel>
 <20160503090045.GB10733@e104818-lin.cambridge.arm.com>
 <3846428.6xx69KGEja@wuerfel> <57288660.9030607@huawei.com>
 <57289C75.50904@huawei.com>
Message-ID: <20160504214949.GA28217@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2016 at 08:41:25PM +0800, Zhangjian (Bamvor) wrote:
> Hi, all
> 
> After apply this patch with my small testcase, the vsyscall of gettimeofday in
> ilp32 works in both big endian and small endian. In this patch, I use the
> different register and offset for ilp32 and lp64. Actually, the
> COMPAT_TVAL_TV_SEC is same as TVAL_TV_SEC(so as to COMPAT_TSPEC_TV_SEC and
> TSPEC_TV_SEC). I add it to keep the logic clear. I also change the version
> of vdso to 4.6. It should change to 2.6.39 if glibc is not update.
> 

[...]

Hi Bamvor,

It works for me as well. Thank you.
I'll incorporate it in next submission.

Yury.
