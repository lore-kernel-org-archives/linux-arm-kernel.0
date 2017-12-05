From: daniel@fooishbar.org (Daniel Stone)
Date: Tue, 5 Dec 2017 20:14:03 +0000
Subject: [RFC PATCH 1/6] drm: Add Content Protection property
In-Reply-To: <20171205173408.GA18425@amd>
References: <20171130030907.26848-1-seanpaul@chromium.org>
 <20171130030907.26848-2-seanpaul@chromium.org>
 <20171205102840.GB12982@amd>
 <20171205104538.b4fxdjad3c46koas@phenom.ffwll.local>
 <20171205173408.GA18425@amd>
Message-ID: <CAPj87rOiUM93c_-ZYK6pf-56bs_=hjK8Kkn8fz1ZH_wQTvV_xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 5 December 2017 at 17:34, Pavel Machek <pavel@ucw.cz> wrote:
> Yes, so... This patch makes it more likely to see machines with locked
> down kernels, preventing developers from working with systems their
> own, running hardware. That is evil, and direct threat to Free
> software movement.
>
> Users compiling their own kernels get no benefit from it. Actually it
> looks like this only benefits Intel and Disney. We don't want that.

With all due respect, you can't claim to speak for the entire kernel
and FLOSS community of users and developers.

The feature is optional: it does not enforce additional constraints on
users, but exposes additional functionality already present in
hardware, for those who wish to opt in to it. Those who wish to avoid
it can do so, by simply not making active use of it.

Cheers,
Daniel
