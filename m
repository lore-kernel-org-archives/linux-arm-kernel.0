From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Dec 2014 10:44:28 +0000
Subject: [PATCH v5 1/3] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <CAAVeFuJhiten-eVLCa2sMG-nsRwjPMiZap8UJM1kNCuRyK-b1w@mail.gmail.com>
References: <1418342706-14755-2-git-send-email-rjui@broadcom.com>
 <1918116.UxUgDPTmcq@wuerfel>
 <CAAVeFuL2MKRA7YLm_wsyftNy-sxgEYPrmqBm8XTRZQb66YF-qw@mail.gmail.com>
 <1628217.66frkAqHMc@wuerfel>
 <CAAVeFuJhiten-eVLCa2sMG-nsRwjPMiZap8UJM1kNCuRyK-b1w@mail.gmail.com>
Message-ID: <20141217104428.GV11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 11:45:01AM +0900, Alexandre Courbot wrote:
> Actually we are not that far from being able to do completely without
> any GPIO number, and maybe that's what we should aim for. I think the
> only remaining offender is the sysfs interface.

And that is a user API, and there's lots of users of it (eg, on Raspberry
Pi platforms.)  So changing it isn't going to be easy - I'd say that it's
impractical.

What you're suggesting would be like re-numbering Linux syscalls.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
