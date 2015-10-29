From: joe@perches.com (Joe Perches)
Date: Thu, 29 Oct 2015 07:14:09 -0700
Subject: [PATCH] get_maintainer: Add subsystem to reviewer output
In-Reply-To: <20151029092007.GN4058@x1>
References: <20151028093907.GP4931@pengutronix.de>
 <20151028095524.GP5828@x1> <5630CA06.7050503@samsung.com>
 <1446050506.2757.109.camel@perches.com> <20151028170116.GI4058@x1>
 <1446052121.2757.120.camel@perches.com> <20151028172208.GJ4058@x1>
 <1446053411.2757.131.camel@perches.com> <20151028174932.GK4058@x1>
 <1446054996.2757.139.camel@perches.com> <20151029092007.GN4058@x1>
Message-ID: <1446128049.2757.165.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-10-29 at 09:20 +0000, Lee Jones wrote:
> On Wed, 28 Oct 2015, Joe Perches wrote:

> > An issue for that will be how multiple subsystem section matching
> > affects the output for reviewers who are also maintainers.
> 
> I think that's okay, becuase the 'MAINTAINERS tag' will be different.
> 
> As an example:
> 
>   Lee Jones <lee.jones@linaro.org> (supporter:DRIVER SUBSYSTEM)
>   Lee Jones <lee.jones@linaro.org> (reviewer:VENDOR DRIVER NAME)

I'm pretty sure I know a little more about the
behavior of the get_maintainers script than you do.
