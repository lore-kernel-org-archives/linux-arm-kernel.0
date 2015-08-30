From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 30 Aug 2015 09:11:21 +0200
Subject: Trying to get a Pogoplug v4 board description added
In-Reply-To: <CAAKvOSg7h=YOVWQ1gKLv-WGw6BGF_rBfp+Zb=za7FkKE2Zwbhg@mail.gmail.com>
References: <CAAKvOShfrRn-E9o2Gjek5xb8xfGucUmO_FRu7c3T7S2V=co-2g@mail.gmail.com>
 <20150829153646.GB31545@lunn.ch>
 <CAAKvOSg7h=YOVWQ1gKLv-WGw6BGF_rBfp+Zb=za7FkKE2Zwbhg@mail.gmail.com>
Message-ID: <20150830071121.GI31545@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 30, 2015 at 09:11:08AM +0800, Andrew Innes wrote:
> I have found the author and I have sent ebbix a pivate message
> informing him of what I'm doing and asking for his email address.
> http://archlinuxarm.org/forum/
> There is a severe lack of licence information.

The author is the one who gets to decide the license. So ask ebbix.

Generally it is GPL, but for some DT files, but less so for Kirkwood,
we are trying for dual license GPL and X11. That would allow for
example FreeBSD to use it, or a boot loader which is not GPL. But
Kirkwood files are at the moment all GPL, and we have not made any
attempts yet to get the core .dtsi files re-licensed. So if its GPL,
thats O.K.

     Andrew
