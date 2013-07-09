From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 9 Jul 2013 09:55:25 +0200
Subject: [lm-sensors] [PATCH 1/2] ARM: dt: t30 cardhu: add dt entry for
 lm90
In-Reply-To: <51DBC058.2040904@nvidia.com>
References: <1372928979-26938-1-git-send-email-wni@nvidia.com>
 <1372928979-26938-2-git-send-email-wni@nvidia.com>
 <51D70483.70203@wwwdotorg.org> <51DA6BD4.1040300@nvidia.com>
 <20130708095024.041a6d57@endymion.delvare>
 <51DA8805.50709@nvidia.com> <20130708131421.GB21638@roeck-us.net>
 <20130709062112.GC17499@mithrandir> <51DBC058.2040904@nvidia.com>
Message-ID: <20130709095525.5158a0a5@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Jul 2013 15:48:40 +0800, Wei Ni wrote:
> On 07/09/2013 02:21 PM, Thierry Reding wrote:
> > It should work out of the box. As a matter of fact the same chip is used
> > on Tamonten and the DTS files use "onnn,nct1008". That used to work. If
> > it no longer does then that's a regression.
> 
> I synced the linux-next from:
> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> and use the tag v3.10-rc7, but in the lm90.c it doesn't have DT support,
> such as "onnn,nct1008".
> I googled it and found there has patch:
> [PATCH] hwmon: (lm90) Add device tree support , which is in:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2013-February/038099.html
> , but it didn't be merged into the linux-next.

It was not, because of the next reply in the same thread:
http://lists.lm-sensors.org/pipermail/lm-sensors/2013-February/038100.html

> which git repository and branch should I use ?

It is supposed to just work. What doesn't work for you exactly?

-- 
Jean Delvare
