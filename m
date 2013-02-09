From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Feb 2013 17:47:18 -0700
Subject: [PATCH] MAINTAINERS: add keyword "tegra" to Tegra section
In-Reply-To: <1360370419.13487.8.camel@joe-AO722>
References: <1360353891-24210-1-git-send-email-swarren@wwwdotorg.org>
 <1360370419.13487.8.camel@joe-AO722>
Message-ID: <51159C96.5080505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 05:40 PM, Joe Perches wrote:
> On Fri, 2013-02-08 at 13:04 -0700, Stephen Warren wrote:
>> (?<!in)tegra
> 
> This doesn't work well.   It matches too many
> words like integral.

Hmmm. That's exactly what the (?<!in) negative look-behind assertion is
attempting to avoid. It works fine here. Is there some dependency on
Perl version or something? My Perl version is v5.14.2.

> I suggest
> 
> K:	(?:\btegra\b|\bTEGRA_)
> 
