From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Thu, 07 Oct 2010 14:36:30 +0200
Subject: Segmentation fault when using ping6
In-Reply-To: <4CADBC7A.6060908@freescale.com>
References: <4CADBC7A.6060908@freescale.com>
Message-ID: <1286454990.2912.153.camel@edumazet-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le jeudi 07 octobre 2010 ? 09:26 -0300, Rogerio Pimentel a ?crit :
> Hi,
> 
> I'm having a "segmentation fault" problem when using ping6.
> 
> When testing on ARM9 platforms (i.MX25 and i.MX27), it returns the error:
> 
> root at freescale ~$ ping6 ::1
> PING ::1 (::1): 56 data bytes
> Segmentation fault
> 
> When testing on ARM11 and ARM Cortex A8 platforms (i.MX31 and i.MX51), 
> it works:
> 
> root at freescale ~$ ping6 ::1
> PING ::1 (::1): 56 data bytes
> 64 bytes from ::1: seq=0 ttl=64 time=0.331 ms
> 64 bytes from ::1: seq=1 ttl=64 time=0.214 ms
> 64 bytes from ::1: seq=2 ttl=64 time=0.176 ms
> 64 bytes from ::1: seq=3 ttl=64 time=0.155 ms
> 
> On all cases, I'm using Linux Kernel 2.6.35 (from Mainline) and Busybox 
> 1.15.0
> 
> Does anybody have any idea?

Do you have something displayed on console ? ( dmesg output )

gdb could tell you where segmentation takes place.
