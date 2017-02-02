From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 2 Feb 2017 17:11:59 +0100
Subject: [PATCHv2 net-next 09/11] net: mvpp2: simplify MVPP2_PRS_RI_*
 definitions
In-Reply-To: <20170106130727.GB14217@n2100.armlinux.org.uk>
References: <1482943567-12483-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1482943567-12483-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170106130727.GB14217@n2100.armlinux.org.uk>
Message-ID: <20170202171159.353d80cc@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 6 Jan 2017 13:07:27 +0000, Russell King - ARM Linux wrote:

>   #define MVPP2_PRS_RI_L2_CAST_MASK              (BIT(10) | BIT(9))
>   #define MVPP2_PRS_RI_L2_UCAST                  0
>   #define MVPP2_PRS_RI_L2_MCAST                  BIT(9)
>   #define MVPP2_PRS_RI_L2_BCAST                  BIT(10)

Your comment makes perfect sense, so I've adopted this second option
you suggested. This is in my v3 I sent a few minutes ago.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
