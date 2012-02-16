From: greg@kroah.com (Greg KH)
Date: Thu, 16 Feb 2012 11:48:45 -0800
Subject: [PATCH] serial/sirf: fixup for changes to pin control
In-Reply-To: <CACRpkdavPdK13cJ-mdDXwbz3jNCSCzaa8LTdMDXOy4mi+pmdmw@mail.gmail.com>
References: <1329417828-6005-1-git-send-email-linus.walleij@linaro.org>
 <74CDBE0F657A3D45AFBB94109FB122FF1790EC8791@HQMAIL01.nvidia.com>
 <CACRpkdavPdK13cJ-mdDXwbz3jNCSCzaa8LTdMDXOy4mi+pmdmw@mail.gmail.com>
Message-ID: <20120216194845.GB5480@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 08:39:39PM +0100, Linus Walleij wrote:
> On Thu, Feb 16, 2012 at 8:01 PM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> > Should this patch be put into the pinctrl tree since that's where the
> > API changed, perhaps even squashed into the original commit to avoid
> > git bisect breakage, unless your branch needs to be stable?
> 
> Hm yeah I will for sure put it into the pinctrl tree.

Great, please feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
