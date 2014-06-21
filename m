From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 21 Jun 2014 16:39:28 -0300
Subject: Dove DT and HDMI on v3.16-rc1 (was: Re: [PATCH RFC 0/5] Dove PMU
 support)
In-Reply-To: <53A19DFA.7030207@gmail.com>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
 <535E079B.6010701@gmail.com> <20140428083144.GB6650@lunn.ch>
 <535F6DAF.1010400@gmail.com>
 <20140615152554.GA13870@n2100.arm.linux.org.uk>
 <53A19DFA.7030207@gmail.com>
Message-ID: <20140621193928.GA5328@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 Jun 04:11 PM, Sebastian Hesselbarth wrote:
[..]
> 
> as said on IRC, I really want this to be sorted out. I prepared a Dove
> DT HDMI quick-hack and pushed it to
> 
> https://github.com/shesselba/linux-dove.git dove-drm-v3.16-rc1
> 

Tested the above branch using mvebu_v7_defconfig + Cubox-specific options
and ran a few basic tests. I know it's not much, but here they are:

* The bootlogo shows up

* Legacy fbdev tests (fb-test, fb-test-rect, mplayer) worked fine in the 
  default mode (1920x1080 in my case).

* Set a few different modes with LibDRM modetest tool:
  modetest -M armada-drm -s 18:640x480
  modetest -M armada-drm -s 18:800x600
  ...
  modetest -M armada-drm -s 18:1920x1080

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
