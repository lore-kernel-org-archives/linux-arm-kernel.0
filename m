From: daniel@fooishbar.org (Daniel Stone)
Date: Fri, 30 Jan 2015 16:08:04 +0000
Subject: [PATCH 03/14] drm/bridge: make bridge registration independent of
 drm flow
In-Reply-To: <CAF6AEGs8GbgYMLmaPjGnXAv=Gsf6gMhNj+Zt0-2GKHOnHv4d4Q@mail.gmail.com>
References: <1421771935-31618-1-git-send-email-ajaykumar.rs@samsung.com>
 <1421771935-31618-4-git-send-email-ajaykumar.rs@samsung.com>
 <CAF6AEGs8GbgYMLmaPjGnXAv=Gsf6gMhNj+Zt0-2GKHOnHv4d4Q@mail.gmail.com>
Message-ID: <CAPj87rMXRGB48k_jnfuxNUh4W6JP63vb4Ak1bkFoNj8wSmq+Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30 January 2015 at 15:37, Rob Clark <robdclark@gmail.com> wrote:
> ok, so I probably should have had a closer look at this before it
> landed in drm-next, so if it is too late to revert (and deal w/
> untangling subsequent patches that depend on this) some of these
> issues we'll just have to fix with follow-on patches.
>
> 1) needs headerdoc for new fxns in drm_bridge.c, and needs to be added
> in drm.tmpl
> 2) as far as I can tell, the new approach to cleaning up bridge
> objects is to just let them leak !?!
>
> I'll also need to update the new bridge in the msm edp code..
> although that isn't such a big deal if I knew how this was *supposed*
> to work.. since what is there now at least doesn't look right..

Given how long these patches sat around doing being passively NACKed
by discussions going around in circles, and how useful they are, I'd
be much more in favour of fixing them up than reverting and going
through the whole circus again ...

Cheers,
Daniel
