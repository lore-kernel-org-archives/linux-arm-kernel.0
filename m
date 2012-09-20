From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 20 Sep 2012 12:32:22 +0200
Subject: [PATCH 00/11] pinctrl: mvebu: pinctrl driver
In-Reply-To: <20120920100254.GE21928@lunn.ch>
References: <1344689809-6223-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <CACRpkda+Kav6RGstSQ9+BCgVV+pR6ca_HmoueODYubX_xYM8Jw@mail.gmail.com>
 <505AD103.8050004@gmail.com> <20120920110424.3cb4daff@skate>
 <20120920100254.GE21928@lunn.ch>
Message-ID: <20120920123222.7f58ee4c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 20 Sep 2012 12:02:54 +0200, Andrew Lunn wrote:

> > Hum, which patches are stalling the integration into the Marvell tree?
> 
> l2 cache, I think.
> 
> The trees Jason built for pull requests in the direction of arm-soc
> had the l2 cache patch as the very first in the series. Now that these
> patches have run into some trouble, its blocking all the patches that
> followed.
> 
> Jason is re-building his trees, throwing out l2 cache for the
> moment. That should allow Olof/Arnd to pull these trees into arm-soc,
> and then Jason will work on integrating the remaining patches not
> already in his trees.

Ok, thanks. Regarding the L2 cache patches, Gr?gory has replied to
Russell comments, and will most likely post an updated version late
next week. So it would be good if the pinctrl/gpio patches could get
merged.

Also, Andrew, could you look at the address decoding patch set I have
sent? I really would like to see that in 3.7 if possible. Thanks!

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
