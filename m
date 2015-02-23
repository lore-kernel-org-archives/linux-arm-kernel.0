From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 23 Feb 2015 23:18:36 +0100
Subject: [PATCH v4 00/20] power_supply: Allow safe usage of power supply
In-Reply-To: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20150223221836.GA4929@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> 
> The patchset fixes invalid memory accesses in certain race scenarios by
> moving ownership of struct power_supply to the core. All drivers are
> modified.

Ok, who can apply the patches? Sebastian?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
