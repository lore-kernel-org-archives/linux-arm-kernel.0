From: olof@lixom.net (Olof Johansson)
Date: Tue, 18 Feb 2014 16:29:55 -0800
Subject: [PATCH] ARM: tegra: Add head numbers to display controllers
In-Reply-To: <5303DAA4.3090608@wwwdotorg.org>
References: <1392761011-21701-1-git-send-email-thierry.reding@gmail.com>
 <5303DAA4.3090608@wwwdotorg.org>
Message-ID: <20140219002955.GE25055@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 03:11:48PM -0700, Stephen Warren wrote:
> On 02/18/2014 03:03 PM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The number of the head specifies the index of the display controller
> > unit and is required to properly configure outputs so that they receive
> > video data from the correct source.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Applied.

-Olof
