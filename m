From: alex.aring@gmail.com (Alexander Aring)
Date: Wed, 11 Nov 2015 19:00:21 +0100
Subject: [RFCv2 1/2] power: domain: add pm_genpd_uninit
In-Reply-To: <20151105143445.GC599@omega>
References: <1446590711-18928-1-git-send-email-alex.aring@gmail.com>
 <1446590711-18928-2-git-send-email-alex.aring@gmail.com>
 <CAPDyKFrkzMZZjFRM7EbqDqmW8EXzV22O_tp8a45LVGQYSn6b3g@mail.gmail.com>
 <20151105143445.GC599@omega>
Message-ID: <20151111180019.GB2621@omega>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 05, 2015 at 03:34:45PM +0100, Alexander Aring wrote:
> 
> What do you suggest to me for e.g. the raspberrypi power domain driver,
> also simple ignore such error handling?
> 

ping, I also can add some WARN_ON_ONCE, if the list for sub-domains,
etc. are not empty. This would then report about wrong use of
pm_genpd_uninit.

- Alex
