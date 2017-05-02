From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 2 May 2017 18:41:32 +1000
Subject: linux-next: build failure after merge of the drm-misc tree
In-Reply-To: <20170502082518.jdk5tqjhvlsqntny@phenom.ffwll.local>
References: <20170421121014.3ee14a83@canb.auug.org.au>
 <20170424112512.582d04da@canb.auug.org.au>
 <20170502082518.jdk5tqjhvlsqntny@phenom.ffwll.local>
Message-ID: <20170502184132.2c1b0299@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, 2 May 2017 10:25:18 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Since this is an all-new driver it might be best to stagger the pull
> requests and merge the new tee subsystem (or whatever it is) after drm?
> 
> Not sure what to best do here ...

This will merge via Dave, so Dave just needs to let Linus know that a
fix up is needed when this merges with the arm-soc stuff in Linus' tree.

-- 
Cheers,
Stephen Rothwell
