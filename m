From: sanjeevsharmaengg@gmail.com (sanjeev sharma)
Date: Wed, 6 May 2015 10:09:46 +0530
Subject: Arm Memory Map clarification
Message-ID: <CAGUYZuQXmJoD_FEtZwX_eBBv-DO019tb1soTXgc-0Qjk_QSSLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello All,

I am working on 3.14 kernel for Nitrogen6x Board and during dealing
with IPU, I have realized that as per Table 2-1 (System memory map) of
the i.MX6 (Q) Reference Manual(Rev2,06/2014) IPU-1 base address is
0x0260_0000 but device Tree Node defined in imx6qdl.dtsi for IPU-1 i.e
alias of IPU0 is at @02400000 and for IPU-2
base address is defined at 0x02A0_0000 as per Table 2-1 (System memory
map) of the i.MX6 (Q) Reference Manual but device Tree Node defined in
imx6q.dtsi for IPU-2 i.e alias of IPU1 is at @02800000.

Why Device Tree node for the IPU starting before actual memory map
address. Is anyone know the reason behind it ?

Thanks in Advance !

Sanjeev Sharma
