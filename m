From: Vadim.Lomovtsev@caviumnetworks.com (Lomovtsev, Vadim)
Date: Fri, 1 Apr 2016 14:26:58 +0000
Subject: [lmbench][question] lat_mem_rd built against ilp32 hangs forever
 with len=2048
In-Reply-To: <BN3PR07MB2643EC7405997C9E58F3FD3E87990@BN3PR07MB2643.namprd07.prod.outlook.com>
References: <BN3PR07MB2643EC7405997C9E58F3FD3E87990@BN3PR07MB2643.namprd07.prod.outlook.com>
Message-ID: <BN3PR07MB2643822975834B66738F0C32879A0@BN3PR07MB2643.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It turns to be lmbench related issue.
Thanks.

-Vadim

________________________________________
From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> on behalf of Lomovtsev, Vadim <Vadim.Lomovtsev@caviumnetworks.com>
Sent: Thursday, March 31, 2016 17:20
To: lmbench-users at lists.sourceforge.net
Cc: Kapoor, Prasun; Norov, Yuri; linux-kernel at vger.kernel.org; Pinski, Andrew; Prakash, Brahmajyosyula; linux-arm-kernel at lists.infradead.org
Subject: [lmbench][question] lat_mem_rd built against ilp32 hangs forever with len=2048

While running lat_mem_rd test build against ILP32 support at ARM64 board it hangs forever with following logs (CPU load is 100%):

./lat_mem_rd -P 1 2048 16 32
0.00049 1.501
0.00098 1.501
0.00195 1.501
[.. skip]
1024.00000 13.076
1536.00000 13.082
2048.00000 13.076

At the same time lat_mem_rd build with lp64 works fine with exactly same args.

Has anyone face such issue before?

My kernel version is 4.2 and ILP32 patches are under development being backported from http://lkml.iu.edu/hypermail/linux/kernel/1601.1/05453.html.
Sources for 4.5 available at https://github.com/norov/linux

Please let me know if any additional information is necessary.

-Vadim
_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
