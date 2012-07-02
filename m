From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 02 Jul 2012 10:25:45 +0100
Subject: [PATCH v5] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <20120702111947.2ce2b3cc@skate>
References: <1340805290-9051-1-git-send-email-gregory.clement@free-electrons.com>
 <4FEB2CC3.7090305@codethink.co.uk> <20120702103016.28b2637e@skate>
 <4FF16797.8070405@codethink.co.uk> <20120702111947.2ce2b3cc@skate>
Message-ID: <4FF16919.3090302@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/12 10:19, Thomas Petazzoni wrote:
> Le Mon, 02 Jul 2012 10:19:19 +0100,
> Ben Dooks<ben.dooks@codethink.co.uk>  a ?crit :
>
>>> Can you share the device tree you're using for your Cogent platform?
>
> Thanks. Please add some memory to your system:
>
>          memory { device_type = "memory"; reg =<0 0>; };
>
> This definitely cannot work.

Ah, thank you. I had it updating the dtb with the ATAGS before
parsing the device tree in my previous setup.

Anyone looking into fixing the problem where it goes bang without
a useful error message if there has been no memory registered?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
