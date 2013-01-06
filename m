From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 6 Jan 2013 23:53:12 +0100
Subject: [PATCH 1/4] arm: mvebu: limit OpenBlocks AX3-4 to 1 GB of RAM
In-Reply-To: <50E9EE7A.1080301@free-electrons.com>
References: <1357315498-4570-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357315498-4570-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <50E710CB.8070007@lunn.ch> <20130104183139.20492204@skate>
 <50E71356.3030203@lunn.ch> <20130104190345.460151d1@skate>
 <50E9EE7A.1080301@free-electrons.com>
Message-ID: <20130106235312.0839a879@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Sun, 06 Jan 2013 22:36:58 +0100, Gregory CLEMENT wrote:

> Until now I didn't notice any problem on this board with the 3GB enable.
> 
> I made more tests since I received this email, I booted (cold and hot boot)
> the board dozens of times, and indeed every 5 or 10 reboot the kernel hanged
> during boot at line:
> "UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)"

I think it hangs at the same place here.

> After applying your patch, I didn't notice any hang after 20 boots. Do you
> have a test pattern which make the kernel to hang each time to be sure that
> it is the root of the problem?

No, I don't have a specific pattern. It just hangs from time to time.
Maybe 1 boot out of 5 or something like that. And it just hangs like it
did for you.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
