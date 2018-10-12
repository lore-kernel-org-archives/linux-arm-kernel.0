From: adam.cottrel@veea.com (Adam Cottrel)
Date: Fri, 12 Oct 2018 11:07:35 +0000
Subject: DMA remote memcpy requests
In-Reply-To: <20181012110326.GA6721@hc>
References: <DM6PR04MB405938028EC04FBD07F3D96AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181012090937.GA12289@arm.com>
 <DM6PR04MB4059742D494D96FC11674A50F2E20@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181012110326.GA6721@hc>
Message-ID: <DM6PR04MB4059733345F887226D8392F4F2E20@DM6PR04MB4059.namprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jan,

> what is the exact hardware revision (shown in /proc/cpuinfo) ?

cat /proc/cpuinfo

processor       : 0
BogoMIPS        : 200.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x43
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0x0a2
CPU revision    : 2

processor       : 1
BogoMIPS        : 200.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x43
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0x0a2
CPU revision    : 2

processor       : 2
BogoMIPS        : 200.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x43
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0x0a2
CPU revision    : 2

processor       : 3
BogoMIPS        : 200.00
Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid
CPU implementer : 0x43
CPU architecture: 8
CPU variant     : 0x0
CPU part        : 0x0a2
CPU revision    : 2

Best,
Adam
