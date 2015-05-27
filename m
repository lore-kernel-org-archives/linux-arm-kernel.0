From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Wed, 27 May 2015 15:00:13 +0200
Subject: [PATCH 1/2] ARM: cache-l2c: Detect whether it's safe to unlock
In-Reply-To: <20150515113448.GI2067@n2100.arm.linux.org.uk>
References: <1431416355-7693-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1431416355-7693-2-git-send-email-sjoerd.simons@collabora.co.uk>
 <20150515113448.GI2067@n2100.arm.linux.org.uk>
Message-ID: <1432731613.2781.13.camel@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Russell,

On Fri, 2015-05-15 at 12:34 +0100, Russell King - ARM Linux wrote:
> On Tue, May 12, 2015 at 09:39:14AM +0200, Sjoerd Simons wrote:
> > To handle that, for caches where special configuration is needed to allow
> > unlocking, check whether this has been setup before unlocking.
> 
> I've come up with a different solution to this, which of course I prefer.
> I'll post the patches later today, thanks.

Did you get round to create/posting those patches? If not, i'm happy to
do a set with your suggested solution as well if you can point me in the
right direction :)

-- 
Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Collabora Ltd.
