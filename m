From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 18 Nov 2015 23:25:43 +0300
Subject: [PATCH v6 18/19] arm64:ilp32: change COMPAT_ELF_PLATFORM to
 report a a subplatform for ILP32
In-Reply-To: <E53A0D4E-EAAF-4956-9E21-599254EB80BB@gmail.com>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-19-git-send-email-ynorov@caviumnetworks.com>
 <564C32AB.4070901@huawei.com>
 <E53A0D4E-EAAF-4956-9E21-599254EB80BB@gmail.com>
Message-ID: <20151118202543.GB11264@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 03:21:05AM -0800, pinskia at gmail.com wrote:
> 
> 
> > On Nov 18, 2015, at 12:11 AM, Zhangjian (Bamvor) <bamvor.zhangjian@huawei.com> wrote:
> > 
> > Hi, Yury
> > 
> >> On 2015/11/18 5:16, Yury Norov wrote:
> >> From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> >> 
> >> To make life for tools (such as gdb) easier when dealing with ILP32 processes,
> >> we report a proper subarchitecture for ILP32 in the ELF auxiliary vectors.
> > I saw some ilp32 relative patches in binutils mailing list. Does gdb
> > fully support ilp32?
> 
> I have a patch set but I have not tested them with the latest kernel patch set yet. The branch is located in the binutils-gdb git is https://sourceware.org/git/?p=binutils-gdb.git;a=shortlog;h=refs/heads/users/pinskia/gdb-aarch64-ilp32 .
> I think it will mostly work except for core support might need to be changed slightly. 
> 
> Thanks,
> Andrew
> > 

Yes, it works mostly. I can read and modify text/data, set breakpoints
etc.

> > Regards
> > 
> > Bamvor
> > 
