From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Mar 2012 14:38:08 +0000
Subject: AMP IPC
In-Reply-To: <CANThrT_wahTpwRDcx-DGQWpDW7j0psKZsk92-4_+vy_Y=xyvtw@mail.gmail.com>
References: <CANThrT_wahTpwRDcx-DGQWpDW7j0psKZsk92-4_+vy_Y=xyvtw@mail.gmail.com>
Message-ID: <201203231438.08577.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 21 March 2012, Jorge Luis Zapata Muga wrote:
> I have to add support for an ARM based board and develop an IPC
> mechanism for its multiple AMP cores it has, looking on the current
> state of things, seems that there are several attempts for this,
> basically:
> 
> - remoteporc/rpmsg based in virtio
> - peripheral image loader (PIL)
> - PRUSS (Programmable Real-time Unit Sub System)
> - maybe others I'm missing?
> 
> Could someone explain what has been adopted? is there some common
> effort for this need? is there some branch where the patches have been
> accepted?
> 

remoteproc/rpmsg is in the arm-soc tree now and I'm submitting it
for inclusion into v3.4. There are lots of others that won't make
it in, and the chances for anything else are drastically decreasing
once we have this one.

I believe all the Linaro members have agreed to use remoteproc/rpmsg
in future products instead of their own solutions and a number of
other people are looking into doing the same.

	Arnd
