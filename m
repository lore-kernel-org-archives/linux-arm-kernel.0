From: joe@perches.com (Joe Perches)
Date: Fri, 08 Feb 2013 17:05:06 -0800
Subject: [PATCH] MAINTAINERS: add keyword "tegra" to Tegra section
In-Reply-To: <51159C96.5080505@wwwdotorg.org>
References: <1360353891-24210-1-git-send-email-swarren@wwwdotorg.org>
 <1360370419.13487.8.camel@joe-AO722> <51159C96.5080505@wwwdotorg.org>
Message-ID: <1360371906.13487.9.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-02-08 at 17:47 -0700, Stephen Warren wrote:
> On 02/08/2013 05:40 PM, Joe Perches wrote:
> > On Fri, 2013-02-08 at 13:04 -0700, Stephen Warren wrote:
> >> (?<!in)tegra
> > 
> > This doesn't work well.   It matches too many
> > words like integral.
> 
> Hmmm. That's exactly what the (?<!in) negative look-behind assertion is
> attempting to avoid. It works fine here. Is there some dependency on
> Perl version or something? My Perl version is v5.14.2.

Integral matches

I don't see any issue with using a leading \b
