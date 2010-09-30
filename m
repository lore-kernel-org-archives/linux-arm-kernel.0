From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 30 Sep 2010 08:58:36 +0200
Subject: Zaurus driver being loaded when it shouldn't.
In-Reply-To: <20100928170704.GA523@redhat.com>
References: <20100928170704.GA523@redhat.com>
Message-ID: <20100930065836.GA1510@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> I have a Dell Adamo laptop which has a wwan device which
> is triggering zaurus.ko to get loaded, probably due to this
> wildcard match..
> 
>  alias:          usb:v*p*d*dc*dsc*dp*ic02isc0Aip00*
> 
> Full lsusb -v is at http://davej.fedorapeople.org/usb

Unfortunately, I don't use usb device mode on zaurus, but hopefully
someone on zaurus list does, and can provide lsusb...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
