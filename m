From: bamvor.zhangjian@huawei.com (Zhangjian (Bamvor))
Date: Wed, 18 Nov 2015 16:11:23 +0800
Subject: [PATCH v6 18/19] arm64:ilp32: change COMPAT_ELF_PLATFORM to report
 a a subplatform for ILP32
In-Reply-To: <1447795019-30176-19-git-send-email-ynorov@caviumnetworks.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-19-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <564C32AB.4070901@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Yury

On 2015/11/18 5:16, Yury Norov wrote:
> From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> 
> To make life for tools (such as gdb) easier when dealing with ILP32 processes,
> we report a proper subarchitecture for ILP32 in the ELF auxiliary vectors.
I saw some ilp32 relative patches in binutils mailing list. Does gdb
fully support ilp32?

Regards

Bamvor
