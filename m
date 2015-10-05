From: ynorov@caviumnetworks.com (Yury Norov)
Date: Mon, 5 Oct 2015 22:10:18 +0300
Subject: [PATCH v5 00/23] ILP32 for ARM64
In-Reply-To: <F6B719D8-1FC0-4B26-A926-40FB6953AAE3@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
 <20150930101918.GA9753@e104818-lin.cambridge.arm.com>
 <20151001191520.GA25295@yury-N73SV> <1708349.DFbfvHcnCR@wuerfel>
 <F6B719D8-1FC0-4B26-A926-40FB6953AAE3@caviumnetworks.com>
Message-ID: <20151005191018.GA5107@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2015 at 12:49:46AM +0300, Pinski, Andrew wrote:

[...]

> Ok, we will rewrite these patches using 32bit time_t and 32bit off_t and
> redo the toolchain support for them.  Note this is going back to the abi
> I had originally done when I submitted my original version when it was
> asked to change time_t to be 64bit. 
> 
> Thanks,
> Andrew

Hi Andrew,

I try to apply your glibc ILP32 patchset on current glibc master, but
there're many merge failures.
        https://sourceware.org/ml/libc-alpha/2014-10/msg00596.html

Could you share more fresh version of it, if you have one?

Are there any special commands or configure options needed 
to enable ILP32 properly?

BR,
Yury.
