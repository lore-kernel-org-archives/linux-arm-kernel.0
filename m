From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Nov 2012 12:24:05 -0800
Subject: [PATCH 00/14] ARM: SPEAr: DT updates
In-Reply-To: <CAKohpom0kMjuHx5jO-LTPKQhy_-r4khKi7UBPB_O-50K42FOeQ@mail.gmail.com>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
 <201211121521.58766.arnd@arndb.de>
 <CAKohpom0kMjuHx5jO-LTPKQhy_-r4khKi7UBPB_O-50K42FOeQ@mail.gmail.com>
Message-ID: <20121121202405.GA15549@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 10:48:16PM +0530, Viresh Kumar wrote:
> On 12 November 2012 20:51, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Sunday 11 November 2012, Viresh Kumar wrote:
> 
> > I tried pulling in patches 2 to 11, but it no longer builds because of the
> > dependency you mentioned. Can you be more specific which branch I need
> > to pull in?
> 
> pinctrl/for-next

for-next is LinusW's unstable branch. If the patches have moved over into
his /devel branch we can normally pull them in as a dependency though. Do
you happen to know which patches we need for this in particular, i.e. at
what point we need to pull in the branch? I don't want to have to search
for it if I can avoid and we try to pull in minimal dependencies if
we can, instead of all his staged code.

We're also running out of time for 3.8 staging, but if you're able to
figure out the above I'll make an attempt to apply the patches from above.


-Olof
