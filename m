From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 Jul 2012 16:04:10 +0200
Subject: [PATCH 1/7] stddev: make it selectable via Kconfig
In-Reply-To: <20120722155013.417c9694@skate>
References: <20120722130301.GI22657@game.jcrosoft.org>
 <1342963142-30339-1-git-send-email-plagnioj@jcrosoft.com>
 <20120722155013.417c9694@skate>
Message-ID: <20120722140410.GD2629@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:50 Sun 22 Jul     , Thomas Petazzoni wrote:
> Le Sun, 22 Jul 2012 15:18:56 +0200,
> Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a ?crit :
> 
> > enable is by default for simple and hush
> > we do not need to NO_SHELL
> > 
> > this allow to save 1KiB
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > ---
> >  commands/Makefile |    2 +-
> >  common/Kconfig    |    5 +++++
> >  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> Hum, I guess this should have been sent to the barebox@ mailing list,
> rather than the linux-arm-kernel@ mailing list, no?
yeap I send it to the wrong ml

Best Regards,
