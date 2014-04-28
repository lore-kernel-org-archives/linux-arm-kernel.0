From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 28 Apr 2014 18:37:40 +0100
Subject: [PATCH 1/3] driver core & of: Mark of_nodes of added device as
 populated
In-Reply-To: <CAL_JsqJQy7ob87=wPOLxn3X0fTrt2QhAEJ2nPTAmCMZqNZp+sw@mail.gmail.com>
References: <1392137610-27842-1-git-send-email-pawel.moll@arm.com>
 <1392137610-27842-2-git-send-email-pawel.moll@arm.com>
 <CAL_JsqJQy7ob87=wPOLxn3X0fTrt2QhAEJ2nPTAmCMZqNZp+sw@mail.gmail.com>
Message-ID: <1398706660.20390.5.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-13 at 13:15 -0600, Rob Herring wrote:
> On Tue, Feb 11, 2014 at 10:53 AM, Pawel Moll <pawel.moll@arm.com> wrote:
> > In "Device Tree powered" systems, platform devices are usually
> > massively populated with of_platform_populate() call, executed
> > at some level of initcalls, either by generic architecture
> > or by platform-specific code.
>
> Go read Grant's and my comments from your last posting.

Right, I can't explain why I missed those. Will do right now.

Pawel
