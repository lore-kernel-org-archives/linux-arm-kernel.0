From: Vadim.Lomovtsev@caviumnetworks.com (Lomovtsev, Vadim)
Date: Thu, 31 Mar 2016 14:20:19 +0000
Subject: [lmbench][question] lat_mem_rd built against ilp32 hangs forever with
 len=2048
Message-ID: <BN3PR07MB2643EC7405997C9E58F3FD3E87990@BN3PR07MB2643.namprd07.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


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
