From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 15 Mar 2011 15:41:50 +0100
Subject: [PATCH 5/8] ARM: PXA: Z2: Add poweroff function
In-Reply-To: <201103121416.19327.marek.vasut@gmail.com>
References: <1299839023-16601-1-git-send-email-anarsoul@gmail.com>
	<201103121206.13251.marek.vasut@gmail.com>
	<201103121330.22949.anarsoul@gmail.com>
	<201103121416.19327.marek.vasut@gmail.com>
Message-ID: <20110315144150.GB1361@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2011-03-12 14:16:19, Marek Vasut wrote:
> On Saturday 12 March 2011 12:30:22 Vasily Khoruzhick wrote:
> > On Saturday 12 March 2011 13:06:13 Marek Vasut wrote:
> > > You have a problem with suspend then ? That'd need a different solution.
> > 
> > I'm still not sure if resume from deepsleep is possible on Zipit Z2, so
> > using deepsleep as poweroff is the only solution we know for now.
> 
> Don't use anything for poweroff, you cannot poweroff the device.

And deepsleep without RAM refresh is what? Sounds very much like
poweroff to me.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
