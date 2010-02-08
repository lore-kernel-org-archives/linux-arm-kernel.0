From: mike@compulab.co.il (Mike Rapoport)
Date: Mon, 08 Feb 2010 11:42:27 +0200
Subject: smsc911x suspend/resume
Message-ID: <4B6FDC83.9090205@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
I'm trying to make suspend/resume work on OMAP3-based system and I'm
encountering issues with resume of SMSC 9220 chip.
After resume the interface is unusable unless I do 'ifconfig eth0 down'
and 'ifconfig eth0 up'.
I would expect that 'ping <some host>' would work right after resume
without need to bring the interface down and up, but probably I miss
something.
Any help would be appreciated.

-- 
Sincerely yours,
Mike.
