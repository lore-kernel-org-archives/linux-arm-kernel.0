From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 7 Mar 2017 19:12:01 +0100
Subject: [PATCHv3 net-next 21/22] net: mvpp2: set dma mask and coherent
 dma mask on PPv2.2
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFE79D2E@AcuExch.aculab.com>
References: <1488902000-2658-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1488902000-2658-22-git-send-email-thomas.petazzoni@free-electrons.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFE79D2E@AcuExch.aculab.com>
Message-ID: <20170307191201.645d23b4@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 7 Mar 2017 17:24:21 +0000, David Laight wrote:

> Are the coherent mappings just used for ring structures?
> If it might be reasonable to allocate them as a single entity,
> thus guaranteeing they all reside in a single 4G region.

Do we have the guarantee that a DMA coherent allocation will not span a
4G boundary?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
