From: wbx@openadk.org (Waldemar Brodkorb)
Date: Tue, 3 Jun 2014 11:42:32 +0200
Subject: oops on cubox-i (v3.15-rc4)
In-Reply-To: <20140523154453.GY3693@n2100.arm.linux.org.uk>
References: <20140509144438.GW14063@waldemar-brodkorb.de>
 <20140511002506.GN12708@titan.lakedaemon.net>
 <20140523101751.GH618@waldemar-brodkorb.de>
 <20140523143845.GD8664@titan.lakedaemon.net>
 <20140523154453.GY3693@n2100.arm.linux.org.uk>
Message-ID: <20140603094231.GH4197@waldemar-brodkorb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Again,
> > > > 
> > > > On Fri, May 09, 2014 at 04:44:38PM +0200, Waldemar Brodkorb wrote:
> > > > > Dear Kernel Hackers,
> > > > > 
> > > > > I am getting kernel oopses on my cubox-i (i2ultra) running
> > > > > Linux 3.15-rc4, when using the box as a samba server with 
> > > > > a local attached 8 GB usb stick. (it also happen with a smaller
> > > > > video on the micro-sd card)
> > > > > The oops happens while playing a movie (4 GB file) on a samba client 
> > > > > (macos x maverick macbook) via vlc (after 5-15 minutes). 
> > > > > 
> > > > > Both systems are connected to a gigabit ethernet switch.
> > > > > 
> > > > > The oops happens with ntfs-3g, ntfs, vfat and ext4 filesystem.

The problem is gone with rc7.
It seems just like a cold, after seven rc'ays it's gone.

Sorry for the noise.
        best regards
                Waldemar 
