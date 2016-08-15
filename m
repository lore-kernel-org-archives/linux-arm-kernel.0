From: joe@perches.com (Joe Perches)
Date: Mon, 15 Aug 2016 10:51:07 -0700
Subject: [PATCH] MAINTAINERS: Switch to kernel.org account for Krzysztof
 Kozlowski
In-Reply-To: <20160815174612.GA8059@kozik-lap>
References: <1471281469-5847-1-git-send-email-krzk@kernel.org>
 <1471282605.4075.70.camel@perches.com> <20160815174612.GA8059@kozik-lap>
Message-ID: <1471283467.4075.73.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-08-15 at 19:46 +0200, Krzysztof Kozlowski wrote:
> On Mon, Aug 15, 2016 at 10:36:45AM -0700, Joe Perches wrote:
> > 
> > On Mon, 2016-08-15 at 19:17 +0200, Krzysztof Kozlowski wrote:
> > > 
> > > Change my email address to kernel.org account instead of Samsung one.
> > > Also switch Maxim MUIC charger drivers from supported to maintained
> > > mode.
> > You should probably add a .mailmap entry too
> > 
> > Krzysztof Kozlowski <krzk@kernel.org>?<k.kozlowski@samsung.com>
> I wasn't sure about this. When is mailmap used? For shortlog and
> "get_maintainers --git"?

git shortlog with option -e and always with get_maintainer.pl
