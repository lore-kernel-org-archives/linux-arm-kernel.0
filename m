From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 5 Jul 2016 20:48:23 -0700
Subject: [GIT PULL 2/3] bcm2835-dt-64-next-2016-07-03
In-Reply-To: <1467593136-29524-3-git-send-email-eric@anholt.net>
References: <1467593136-29524-1-git-send-email-eric@anholt.net>
 <1467593136-29524-3-git-send-email-eric@anholt.net>
Message-ID: <577C7F87.8050503@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/07/2016 17:45, Eric Anholt a ?crit :
>   Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/anholt/linux tags/bcm2835-dt-64-next-2016-07-03
> 
> for you to fetch changes up to 02d08603649816a941246c18252e5c41fd07625a:
> 
>   ARM: bcm2837: dt: Add the ethernet to the device trees (2016-06-07 15:23:08 -0700)
> 
> ----------------------------------------------------------------
> This pull request brings in the Raspberry Pi 3 DT for its arm64
> support.  Note that it also merges in the ethernet DT changes so that
> the Pi3's ethernet can also get the MAC address.
> 
> ----------------------------------------------------------------
> Eric Anholt (3):
>       dt-bindings: Add root properties for Raspberry Pi 3
>       ARM: bcm2835: Add devicetree for the Raspberry Pi 3.
>       Merge tag 'bcm2835-dt-ethernet' into HEAD
> 
> Gerd Hoffmann (1):
>       ARM: bcm2837: dt: Add the ethernet to the device trees
> 
> Lubomir Rintel (1):
>       ARM: bcm2835: dt: Add the ethernet to the device trees

Merged, thanks Eric!
-- 
Florian
