From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 9 Sep 2016 16:32:06 -0500
Subject: [RFC 0/1] misc: Add Allwinner Q8 tablet hardware manager
In-Reply-To: <20160901190820.21987-1-hdegoede@redhat.com>
References: <20160901190820.21987-1-hdegoede@redhat.com>
Message-ID: <CAL_JsqJVkPPiDh66nhfh0D7BvkZ7KKN0X7uhfPGgiYbc2Ca1rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 2:08 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi All,
>
> Here is a first RFC for the q8 tablet hw-manager I've been talking
> about for a while now.
>
> The touchscreen part is finished, I'll start working on the
> accelerometer bits next.

This at least partially overlaps with the "overlay manager" just
posted. A dev board having different devices attached and a production
device have 2nd source components are not really different problems.
We need a common solution and can't have each platform making up their
own scheme. What's different for you is how you select what changes or
overlay to apply and that is fine to be platform specific. I think you
should be using overlays here as well.

> Note that this requires the "of: changesets: Introduce changeset
> helper methods" patch from Pantelis. If that is still not upstream
> when I'm ready to post a non RFC, I'll post a new version of that
> myself.

I'm waiting for it to be reposted. IIRC, I only had some minor comments.

Rob
