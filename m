From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 16 Nov 2014 09:43:53 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <54685C18.1020109@metafoo.de>
References: <20141116075928.GA9763@amd>
 <54685C18.1020109@metafoo.de>
Message-ID: <20141116084353.GC30646@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2014-11-16 09:11:04, Lars-Peter Clausen wrote:
> On 11/16/2014 08:59 AM, Pavel Machek wrote:
> >[...]
> >+	adp1653: adp1653 at 30 {
> >+		compatible = "ad,adp1653";
> 
> The Analog Devices vendor prefix is adi.

Thanks, will be fixed in next version.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
