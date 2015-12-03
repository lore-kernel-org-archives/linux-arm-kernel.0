From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 3 Dec 2015 20:05:06 +0300
Subject: [RFC PATCH v6 00/17] ILP32 for ARM64
In-Reply-To: <1449010556-31699-1-git-send-email-iharutyunov@sonicwall.com>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <1449010556-31699-1-git-send-email-iharutyunov@sonicwall.com>
Message-ID: <20151203170506.GA31818@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


[Please don't drop people from CC.]

On Tue, Dec 01, 2015 at 02:55:56PM -0800, Iosif Harutyunov wrote:
> Sonicwall is very interested in ILP32, is there a way we can get access to the SuSe builds?
> 
> Thanks
> Iosif,_
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

You can build it by yourself.

Kernel:
https://github.com/norov/linux/tree/ilp32-v6-rfc3

Glibc:
https://github.com/norov/glibc/tree/thunderx-ilp32-32time_toff_t

>From Andrew:
GCC and binutils support is upstream already and has been for over a
year now.  gdb support can be found on the
users/pinskia/gdb-aarch64-ilp32 branch of the binutils-gdb.git repo on
sourceware.org.
(https://sourceware.org/git/?p=binutils-gdb.git;a=shortlog;h=refs/heads/users/pinskia/gdb-aarch64-ilp32).

Latest discussion is here:
https://lkml.org/lkml/2015/11/17/802

BR,
Yury.
