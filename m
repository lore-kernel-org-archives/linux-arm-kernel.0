From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Mon, 23 Mar 2015 01:49:57 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <CAMuHMdVLWffQW3d_4z9RAQOg8BCUCSU6ny3yG0poZ_7v=ozNbw@mail.gmail.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
 <HK2PR06MB05611C6D6CED1E32F4617D158A010@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <20150320222320.GL8656@n2100.arm.linux.org.uk>
 <HK2PR06MB05611E6828E494FB938179658A0F0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdVLWffQW3d_4z9RAQOg8BCUCSU6ny3yG0poZ_7v=ozNbw@mail.gmail.com>
Message-ID: <HK2PR06MB05614A6A877BCD6A2B7EA9418A0D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Yes, it's making more sense to me now.

> BTW, since you're asking about SMP=y, I guess you're not just interested in running XIP_KERNEL=y on r7s72100, which is UP?

Yes. While the r7s72100 itself has some nice capabilities suited for XIP, I'm thinking what else this could be expanded to.

Chris
