From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 3 Dec 2013 08:46:50 +0200
Subject: [RFC][PATCHv6+++ 01/13] of: introduce
 of_property_for_earch_phandle_with_args()
In-Reply-To: <CAL_JsqKDokswB1jJN7ZT-Us0h=uTf5qHLZFUJfGFkXBjdO5XjA@mail.gmail.com>
References: <20131128.145818.1345100874304396564.hdoyu@nvidia.com>
 <20131129.134625.431945240074254704.hdoyu@nvidia.com>
 <529B8739.60701@wwwdotorg.org>
 <20131202.130220.1404999403649937134.hdoyu@nvidia.com>
 <CAL_JsqKDokswB1jJN7ZT-Us0h=uTf5qHLZFUJfGFkXBjdO5XjA@mail.gmail.com>
Message-ID: <20131203084650.bf498e1eb6883e38d873ef4a@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Dec 2013 15:39:25 +0100
Rob Herring <robherring2@gmail.com> wrote:

> On Mon, Dec 2, 2013 at 5:02 AM, Hiroshi Doyu <hdoyu@nvidia.com> wrote:
> > Stephen Warren <swarren@wwwdotorg.org> wrote @ Sun, 1 Dec 2013 20:00:09 +0100:
> >
> >> On 11/29/2013 04:46 AM, Hiroshi Doyu wrote:
> >> ...
> >> > Iterating over a property containing a list of phandles with arguments
> >> > is a common operation for device drivers. This patch adds a new
> >> > of_property_for_each_phandle_with_args() macro to make the iteration
> >> > simpler.
> >> >
> >> > Introduced a new struct "of_phandle_iter" to keep the state when
> >> > iterating over the list.
> >> >
> >> > Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
....

Rob, thank you for review.
I'll fix them and put this one into the next v7 series.
